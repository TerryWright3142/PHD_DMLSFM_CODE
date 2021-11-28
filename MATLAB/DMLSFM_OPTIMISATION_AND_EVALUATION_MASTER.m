%DMLSFM_OPTIMISATION_AND_EVALUATION_MASTER
s
clear;
clf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load libraries
addpath('.\ALPAO_DM');
dllFolder = '.\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = '.\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
%libfunctions(winDLL); % will list out functions available in the dll

bEvaluate = 1; % optimise = 0, evaluate  = 1
%
disp('init daq: the daq sends a signal to the and gate, which has the other signal the trigger output from the DM.  Hence the DAQ can be used to arm the DM etc');
d = daq.getDevices;
daq = daq.createSession('ni');
addDigitalChannel(daq, 'Dev2', 'port0/line1', 'OutputOnly')
outputSingleScan(daq, 0); % ensure that the daq is off
%
%INIT DM
disp('Init Alpao');
%  ensure that best flat of DM is rms < 25 nm
dm = Alpao97_15_4th_Nov_20(); % ensure that displacement from optic axis X,Y accounted for and also the physical angle of the DM
dm.Init();
%corrections due needed due to misalignment of the optical axis with the centre of the
%DM  descibed as X,Y 
dm.X = 0.5;
dm.Y = -0.2;

%
%
dtsz = '15_12_20';
detailsz = 'Zernike_opt1';
dtsz1 = '15_12_20';
detailsz1 = 'Zernike_opt1';
szOptimisationCoefficients = [dtsz detailsz '-cmds.mat']; %use these commands for evaluation
szOptimisationCoefficients1 = [dtsz1 detailsz1 '-cmds.mat']; %save commands here after optimisation
bLoadPrevious = true; %otherwise use high-NA defocus alone
%
%
%
%init memory map for IPC between MASTER and SLAVE
disp('init mem map');
delete('test.dat');
mem_map = cMMap('test.dat');
mem_map.bEvaluate = bEvaluate;%%important to say if in evaluation mode = 1, or optimisation mode = 0
mem_map.interpose_time = 2.5; %%% this is the time between the keyposes which will be lerped
% when not lerped then the interpose time is the time between 2 optimised defocus positions eg 0 and 10um
% the exposure will be chopped down and strobed by the DAQ6363
bLerp = true; % linearly interpolate or move the mirror in discrete jumps
mem_map.pose_change_to_exposure_delay = 0; %this carries the delay from the pulse signalling that the DM is playing through a sequence to the required pose to strobe
%so it is dependent on the stage position and needs to be updated as the
%stage is moved
extraFlashDelayPause = mem_map.interpose_time - 2;% only used if not lerping
subpose_time = 0.065; %% (measured empirically) subpose time (checked with flash timestamps) is the quickest time to send
%commands to the DM. This does not mean that the DM has completed its pose
%change in that time - but presumably it means that the actuator coils are
%energised
subposeRepeats = ceil(mem_map.interpose_time/subpose_time);
mem_map.interpose_time = subpose_time * subposeRepeats;
%field of view of the orca flash
if ~mem_map.bEvaluate
    %optimisation roi used since 28_8_19
    mem_map.cx = 200;
    mem_map.cy = 200; 
    mem_map.x0 = 900; 
    mem_map.y0 = 900; 
else
    % use full screen to evaluate  
    mem_map.cx = 2048; 
    mem_map.cy = 2048; 
    mem_map.x0 = 1;
    mem_map.y0 = 1;  
end
%the mirror will initially be set to Botcherby corresponding to
mem_map.defocus = 10*([[5:-1:-5] [-3 -1 1 3]]);
ix_offset_start =  12; % the poses between ix_offset_start and ix_offset_end are used to ensure average pose is flat
ix_offset_end = 15;
mem_map.numDefocus = numel(mem_map.defocus);
mem_map.zeroStageCorrection = 0; %add to stage position in order to measure field curvature
mem_map.x = [0 0 0 0 0 0 0 0 0 0 0 0 -0.6:0.02:0.6 0 0 0 0 ];  %optimisation amplitudes
mem_map.num_x = numel(mem_map.x); 
% some of these need to be REFACTORED
mem_map.num_warmup = 50;
mem_map.num_background = 30; % NOT USED ANY MORE
mem_map.num_optimise = numel(mem_map.x); 
mem_map.num_best = 20;
mem_map.num_evaluate = 30;
mem_map.winStamps_background = zeros(1, mem_map.num_background); % NOT USED
mem_map.winStamps_optimise = zeros(1, mem_map.num_optimise); % NOT USED  
mem_map.winStamps_best = zeros(1, mem_map.num_best); % NOT USED
mem_map.winStamps_evaluate = zeros(1, mem_map.num_evaluate); % NOT USED
mem_map.win_freq = calllib(winDLL, 'Win_QueryPerformanceFrequency');%NOT USED (NOW FULLY ELECTRONIC TIMING)
%
mem_map.CreateMap();
%
%
%
% 
stagePos = 1:11;  %%% stage positions that will be optimised
optimisation_functions =  { ...
    BotchF1W, BotchF10W ...
    I1 ...
    Z4 Z5 Z6 Z7 Z8 Z9 Z10 Z11 Z12 Z13 Z14 Z15 Z16 Z17 Z18 Z19 Z20 Z21 Z22 Z23 Z24 Z25 Z26 Z27 Z28}; %%function pointers      
opt_fn_sz = {'BotchF1', 'BotchF10' 'I1' ...
    'Z4' 'Z5' 'Z6' 'Z7' 'Z8' 'Z9' 'Z10' 'Z11' 'Z12' 'Z13' 'Z14' 'Z15' 'Z16' 'Z17' 'Z18' 'Z19' 'Z20' 'Z21' 'Z22' 'Z23' 'Z24' 'Z25' 'Z26' 'Z27' 'Z28'}; %%function names   
opt_choice = [3 3 3 3 3 3 3 3 3 2 2 2 2 1 1  4:18  4:18 4:18]; % sequence of modes to optimise
%initialise opt_fns_coeffs which contains the amplitudes for each defocus
if ~mem_map.bEvaluate  
    if bLoadPrevious
        mmm = load(szOptimisationCoefficients);
        opt_fns_coeffs = mmm.opt_fns_coeffs;        
    else
        for f = 1 : mem_map.numDefocus
                opt_fns_coeffs(f, 1) = mem_map.defocus(f); 
        end
    end
else  
    mmm = load(szOptimisationCoefficients);
    opt_fns_coeffs = mmm.opt_fns_coeffs;  
end
%
% construct the DM commands for each defocus
cmds_values = zeros(mem_map.numDefocus, 97);
for f = 1:mem_map.numDefocus   
    cmds_values(f,:) = dm.GetCmdsFromSurface(dm.GetSurfaceFromFunction( ...
            @(p, th) combine_optimisation_function(p, th, opt_fns_coeffs(f, :), optimisation_functions) ...
            ));          
end
%%% if bLerp then linearly interpolate to get the intermediate commands
cmds = GenerateSubCmds1(mem_map,  subposeRepeats, cmds_values, bLerp,ix_offset_start, ix_offset_end);
cmds_optimisation = zeros(size(cmds,1), subposeRepeats*mem_map.numDefocus, mem_map.num_x);
cmds_tmp = cmds;
cmds_values_tmp = cmds_values;
opt_fns_coeffs_tmp = opt_fns_coeffs;
%
%
%warm up DM
disp('warm up DM');
dm.SetPattern(cmds(:),0);
pause(300); %5 min warmup
dm.Stop();
%
disp('start the slave');
WaitForSlave(mem_map);
%both slave and master running here
%
%
%
mem_map.Set_bFlashReady(0); % this flag is used to ensure correct timing between slave and master
if ~mem_map.bEvaluate
    
    tic();   
    outputSingleScan(daq, 0); %turn off triggers from the DM
    dm.SetPattern(cmds(:),0); % oscillate the mirror
    for stage_ix = stagePos
        fprintf('stage_ix:%d\n', stage_ix);  
        %move the stage to the new position
        outputSingleScan(daq, 0);  %dont send triggers
        stage_fileID = fopen('..\EXP_date_2_10_18_STAGE_CONTROLLER\stage_config.xml', 'w');
        fprintf(stage_fileID, '<config>\r\n\r\n');      
        fprintf(stage_fileID, '<control>\r\n');
        fprintf(stage_fileID, '<stagePosition>%f<\\stagePosition>\r\n', mem_map.defocus(stage_ix) + mem_map.zeroStageCorrection);
        fprintf(stage_fileID, '<\\control>\r\n\r\n'); 
        fprintf(stage_fileID, '<\\config>\n');  
        fclose(stage_fileID); 
        pause(30);
        
        mem_map.Set_current_defocus(mem_map.defocus(stage_ix)); %set current defocus in mem-map
        mem_map.Set_cur_best_score(0); % clear best score
        if bLerp
           mem_map.Set_pose_change_to_exposure_delay((stage_ix-1)*mem_map.interpose_time);
        else
           mem_map.Set_pose_change_to_exposure_delay((stage_ix-1)*mem_map.interpose_time + extraFlashDelayPause);
        end

        %The rule is that any process which stops the oscillation of the
        %mirror must start it.  
        for fff_opt_ix = 1: numel(opt_choice) 
            opt_ix = opt_choice(fff_opt_ix);          
            fprintf('opt_ix:%d   fff_opt_ix:%d\n', opt_ix, fff_opt_ix);
            disp(opt_fn_sz(opt_ix)); % prints out the name of the mode being optimised

            mem_map.Set_slave_state(0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('1. improve cmds if required based on the results of last evaluation images');
% tic();
            outputSingleScan(daq, 0);
            if mem_map.Get_bImprovement()
                 mem_map.Set_bImprovement(0); 
                if fff_opt_ix > 6  % first few are just to warm up the Flash
                    disp('IMPROVED');
                    opt_fns_coeffs = opt_fns_coeffs_tmp;
                    cmds_values = cmds_values_tmp;
                    cmds = cmds_tmp;   
                else
                    %ignore the optimum
                    mem_map.Set_cur_best_score(0);
                end
            end 
%toc()
disp('1. end');
%tic%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('2. calculate cmds for each amount of applied mode');
%tic();
            for fff = 1 : mem_map.num_x   
                ccc1 = cmds_values;
                opt_fns_coeffs1 = opt_fns_coeffs;
                opt_fns_coeffs1(stage_ix, opt_ix) = opt_fns_coeffs1(stage_ix, opt_ix) + mem_map.x(fff);              
                ccc1(stage_ix,:) = dm.GetCmdsFromSurface(dm.GetSurfaceFromFunction(@(p, th) combine_optimisation_function(p, th, opt_fns_coeffs1(stage_ix, :), optimisation_functions)));                   
                cmds_optimisation(:,:,fff) = GenerateSubCmds1(mem_map, subposeRepeats, ccc1, bLerp,ix_offset_start, ix_offset_end);        
            end 
%toc()
disp('2. end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('3. wait for flash to be ready');
%tic();
            %wait until the flash is ready
            while mem_map.Get_bFlashReady() == 0
                pause(0.1);
            end
            dm.Stop();
            
 %toc()
 %pause(1);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 disp('3. end');
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 disp('4. play optimisation cmds on the dm');
 %tic();
            dm.Stop();
            outputSingleScan(daq, 1); 
            for fff = 1:mem_map.num_x
                % play a single sequence on the DM for each amplitude
                c1 = cmds_optimisation(:,:,fff);
                dm.SetPattern(c1(:), 1);
            end        
            mem_map.Set_bFlashReady(0);
            outputSingleScan(daq, 0);
            %cannot execute a new SetPattern during bus transer to the
            %dm so put a pause in to prevent this.
             pause(0.05);
            dm.SetPattern(cmds(:),0);
 %toc()
 disp('4 end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('5. wait for the slave to calculate image statistics');
%tic();
            %wait for the slave to analyse the results and find the
            %optimisation
            while ~(mem_map.Get_slave_state() == 1)
                pause(0.1);
            end
%toc()
disp('5 end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('6. calculate new optimised surface');
%tic();
            opt_fns_coeffs_tmp = opt_fns_coeffs;
            opt_fns_coeffs_tmp(stage_ix, opt_ix) = opt_fns_coeffs_tmp(stage_ix, opt_ix) + mem_map.Get_xopt(); 
            cmds_values_tmp = cmds_values;
            cmds_values_tmp(stage_ix,:) = dm.GetCmdsFromSurface(dm.GetSurfaceFromFunction(@(p, th) combine_optimisation_function(p, th, opt_fns_coeffs_tmp(stage_ix, :), optimisation_functions)));                            
            cmds_tmp = GenerateSubCmds1(mem_map, subposeRepeats, cmds_values_tmp, bLerp, ix_offset_start, ix_offset_end);
%toc()
disp('6. end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('7. wait for the flash to be ready');
%tic();
            %wait for the camera to be ready
            while mem_map.Get_bFlashReady() == 0
                pause(0.1);
            end
            dm.Stop();
            dm.Flatten();
%toc()
disp('7. end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('8. play optimisation cmds on the dm');
%tic();
            dm.Stop();
            outputSingleScan(daq, 1);
            time0 = WinGetTime();
            time1 = time0 + mem_map.num_best * mem_map.numDefocus * mem_map.interpose_time * mem_map.win_freq/1000;
            dm.SetPattern(cmds_tmp(:), 0);
            WaitFor(time1);
            dm.Stop();
            mem_map.Set_bFlashReady(0);
            outputSingleScan(daq, 0);
            dm.SetPattern(cmds(:),0);
%toc()
disp('8. end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('9. wait for the slave to find image scores');
%tic();
            %wait for the Slave to decide if this is the best opt
            while ~(mem_map.Get_slave_state==2)
                pause(0.5);
            end
%toc()
disp('9. end');

        end
    end
    dm.Stop();
    
    Speak('finished optimisation');
    disp('finished optimisation');
    save(szOptimisationCoefficients1, 'opt_fns_coeffs');
    toc()
else
    tic();   
    outputSingleScan(daq, 0);
    dm.SetPattern(cmds(:),0);
    for stage_ix = stagePos
            fprintf('stage_ix:%d\n', stage_ix);  
            %MOVE STAGE
            outputSingleScan(daq, 0);  %dont send triggers
            stage_fileID = fopen('..\EXP_date_2_10_18_STAGE_CONTROLLER\stage_config.xml', 'w');
            fprintf(stage_fileID, '<config>\r\n\r\n');      
            fprintf(stage_fileID, '<control>\r\n');
            fprintf(stage_fileID, '<stagePosition>%f<\\stagePosition>\r\n', mem_map.defocus(stage_ix) + mem_map.zeroStageCorrection);
            fprintf(stage_fileID, '<\\control>\r\n\r\n'); 
            fprintf(stage_fileID, '<\\config>\n');  
            fclose(stage_fileID); 
            pause(30);

            mem_map.Set_current_defocus(mem_map.defocus(stage_ix)); %to load correct points
            mem_map.Set_cur_best_score(0);
            if bLerp
               mem_map.Set_pose_change_to_exposure_delay((stage_ix-1)*mem_map.interpose_time);
            else
               mem_map.Set_pose_change_to_exposure_delay((stage_ix-1)*mem_map.interpose_time + extraFlashDelayPause);
            end

            for repeats = 1:6
                %TELL SLAVE TO GET READY

                mem_map.Set_slave_state(0);
disp('1. wait for the flash to be ready');
                %wait until the flash is ready
                while mem_map.Get_bFlashReady() == 0
                    pause(0.1);
                end
                dm.Stop(); 
disp('1. end');
                
disp('2. play optimisation cmds on the dm');
%tic();
            %will play num.evaluate times
            dm.Stop();
            outputSingleScan(daq, 1);
            %NewPlayCmdsOnMirror_12_1_20(mem_map, dm, cmds_best, mem_map.num_best)
            time0 = WinGetTime();
            time1 = time0 + mem_map.num_evaluate * mem_map.numDefocus * mem_map.interpose_time * mem_map.win_freq/1000;
            dm.SetPattern(cmds(:), 0);
            WaitFor(time1);
            dm.Stop();
            mem_map.Set_bFlashReady(0);
            outputSingleScan(daq, 0);
            dm.SetPattern(cmds(:),0);
%toc()
disp('2. end');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('3. wait for slave to be ready to continue');
%tic();
            %wait for the Slave to decide if this is the best opt
            while ~(mem_map.Get_slave_state==2)
                pause(0.5);
            end
%toc()
disp('3. end');

            end
    end
end
%
%
Speak('finished');

%Shutdown
clear daq;
clear mem_map
calllib(winDLL, 'Win_ShutdownSpeechEngine');
dm.Stop();
dm.Shutdown();
unloadlibrary(winDLL);
clear;
disp('shutdown');

