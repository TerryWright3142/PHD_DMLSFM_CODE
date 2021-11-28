%EXP_13_1_21_DMLSFM_SCAN_MASTER
% this is to be used with EXP_13_1_21_DMLSFM_SCAN_SLAVE
% this is to be used with labVIEW EXP_13_1_21_DMLSFM_SCAN.vi
% This allows you to capture a stack of images through the volume 
% 
%
% initially run the MASTER and after it has initialised it will tell you to
% run the SLAVE.  Then run the VI. Then all 3 processes should be
% correctly synche.
% yoou cannot change the number and range of images in the volume at
% runtime, you have to restart the entire sequence.
clear;
clf;
%load libraries
addpath('..\');
addpath('..\..\ALPAO_DM');
Script_Zernike_Modes; % contain botcherby and zernikes
%load win_mutex.dll and win_mutex.h which contains useful Windows API
%functions
dllFolder = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
%libfunctions(winDLL); % will list out functions available in the dll
calllib(winDLL, 'Win_InitSpeechEngine'); % initial SAPI api
Speak('This will capture a sequence of planes through the volume');
%
%
%initialise NI DAQ 6008
disp('init daq: the daq sends a signal to the and gate, which has the other signal the trigger output from the DM.');
d = daq.getDevices;
daq = daq.createSession('ni');
addDigitalChannel(daq, 'Dev2', 'port0/line1', 'OutputOnly')
outputSingleScan(daq, 0); % ensure that the daq is off
%
%
%initialise the DM
disp('Initialise the DM');
dm = Alpao97_15_4th_Nov_20(); 
dm.Init();

%init memory map which is used for IPC, between the MASTER SLAVE and
%labVIEW script
disp('Initialise memory map which is used for IPC with the LabVIEW script EXP_13_1_21_DMLSFM_HCI_STROBE.vi');
delete('test.dat');
mem_map = cMMap('test.dat');
%
%
mem_map.exposure_time = 2;
mem_map.interpose_time = 2.5; %time between control poses
bLerp = true; %linearinterpolation between poses or  steps between control poses
mem_map.pose_change_to_exposure_delay = 0; %delay between TTL pulse from DM at the start of the sequence of poses and the camera triggerTTL pulse
extraFlashDelayPause = mem_map.interpose_time - mem_map.exposure_time - 3;% only used if not lerpingto ensurethe DM has time to settle
subpose_time = 0.065; %% (measured empirically) subpose time (checked with flash timestamps) is the quickest time to send
%commands to the DM. This does not mean that the DM has completed its pose
%change in that time - but presumably it means that the actuator coils are
%energisedand there is an impulseon the membrane
subposeRepeats = ceil(mem_map.interpose_time/subpose_time); 
mem_map.interpose_time = subpose_time * subposeRepeats;

mem_map.defocus = 10*([[5:-1:-5] [-3 -1 1 3]]); %defocus positions of control poses
ix_offset_start =  12; %poses to share the offset to keep the average flat
ix_offset_end = 15;
mem_map.numDefocus = numel(mem_map.defocus);
%save some information specifically to be used by NI DAQ6363
mem_map.DAQ_samples_per_pose = subposeRepeats;
mem_map.DAQ_sample_rate = 1/subpose_time*1000;
mem_map.DAQ_num_samples = ceil(subposeRepeats * numel(mem_map.defocus));
% field of view
mem_map.cx = 2048; 
mem_map.cy = 2048; 
mem_map.x0 = 1;
mem_map.y0 = 1; 
% images to be taken each volume
mem_map.defocus_start = -50; %microns
mem_map.defocus_end =  50;  
mem_map.num_exposures = 10;   % so linspace(-50,50,10)

mem_map.CreateMap();
disp(['interpose '  num2str(mem_map.interpose_time)]);
disp(['exposure time ' num2str(mem_map.exposure_time)]);
disp(['sample_rate ' num2str(mem_map.DAQ_sample_rate)]);
disp(['num_samples ' num2str(mem_map.DAQ_num_samples)]);
disp(['defocus_start ' num2str(mem_map.defocus_start)]);
disp(['defocus_end ' num2str(mem_map.defocus_end)]);
disp(['num_exposures' num2str(mem_map.num_exposures)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimisation_functions =  { ...
    BotchF1W, BotchF10W...
    I1 ...
    Z4 Z5 Z6 Z7 Z8 Z9 Z10 Z11 Z12 Z13 Z14 Z15 Z16 Z17 Z18 Z19 Z20 Z21 Z22 Z23 Z24 Z25 Z26 Z27 Z28}; %%function pointers      

szOptimisationCoefficients = '15_12_20Zernike_opt1-cmds.mat'; 
disp(['Load optimisation commands from ' szOptimisationCoefficients]);
bLoadCommands = true;
if bLoadCommands
    mmm = load(szOptimisationCoefficients);
    opt_fns_coeffs = mmm.opt_fns_coeffs;
else
    for f = 1 : mem_map.numDefocus
       opt_fns_coeffs(f, 1) = -mem_map.defocus(f); 
    end
end

%corrections due needed due to misalignment of the optical axis with the centre of the
%DM  descibed as X,Y (1) and also due to displacement of the centre of the pupil due to rotation
%of the objective (2)

dm.X = 0.5 + 0;  %correction (1) + (2)
dm.Y = -0.2 - 1.35;
objective_inclination = 48.6;
rotation_of_objective = 180 - objective_inclination; %the pupil is rotated clockwise through this angle
% the angle convention here is that positive is clockwise 

%turn the amplitudes in opt_fns_coeffs into cmds_values
cmds_values = zeros(mem_map.numDefocus, 97);
for f = 1:mem_map.numDefocus   
    cmds_values(f,:) = dm.GetCmdsFromSurface(dm.GetSurfaceFromFunction( ...
            @(p, th) combine_optimisation_function(p, th, opt_fns_coeffs(f, :), optimisation_functions) ...
            ));          
end
%%% if bLerp then linearly interpolate cmds_values to get the full set of
%%% intermediate commands and store in cmds
cmds = GenerateSubCmds1(mem_map,  subposeRepeats, cmds_values, bLerp,ix_offset_start, ix_offset_end);

figure(1);
act_id = 47;
plot((1:size(cmds,2))*subpose_time,cmds(act_id,:));
ylabel(['actuator ' num2str(act_id) ' control signal']);
xlabel('Time(ms)');
title (['Volume ramp for interpose ' num2str(mem_map.interpose_time) ' ms: ' num2str(1000/(mem_map.interpose_time*15)) 'vol/sec']);
disp('completed DAQ and DM initialisation');

%% Master has init now wait for the slave to init
bSlave = false;
disp('Start the slave  EXP_13_1_21_DMLSFM_SCAN_SLAVE');
if bSlave
    Speak('Start the slave');
    
end

%% Start the Labview code
disp('Now start the labVIEW script EXP_13_1_21_DMLSFM_SCAN.vi');
Speak('Start labview code');

%%
%start the mirror oscillating
outputSingleScan(daq, 1);
dm.SetPattern(cmds(:),0);

disp('DM started');
%%
% stop the mirror oscillating
outputSingleScan(daq, 0);
dm.Stop();
dm.Flatten();
disp('stopped');

%%

clear daq;
clear mem_map
calllib(winDLL, 'Win_ShutdownSpeechEngine');
dm.Stop();
dm.Shutdown();
unloadlibrary(winDLL);
clear;
disp('shutdown');



