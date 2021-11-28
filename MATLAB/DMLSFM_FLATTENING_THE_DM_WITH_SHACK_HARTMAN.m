%FLATTENING_DM_WITH_SHACK_HARTMANN
%
%
%
%This script uses the Shack Hartmann Wavefront Sensor (SHWFS) to flatten the Alpao DM97-15 membrane deformable mirror (DM). 
%Prior to running script, the SHWFS needs to take a background image of a lambda/14 flat in the same place as the
%DM. It will aim to make the DM as flat as that lambda/14 reference flat
%

%
clear
addpath('.\SHACK_HARTMAN\4_SHACK_HARTMAN');
addpath('.\ALPAO_DM');
%
%include win_mutex.dll with useful Windows API functions
dllFolder = '.\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = '.\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
libfunctions(winDLL);
INFINITE           = hex2dec('FFFFFFFF');
%
%
% store results in this folder
szResults = '20.12.8/'; 
mkdir(szResults);
%% Shack Hartman camera
disp('Init Shack Hartman Wavefront Sensor');
sh = Shack_Hartman() ;
sh.Init();
[shWidth,shHeight] = size(sh.CaptureImage());


%% DM 
disp('Init Alpao');
%dont use best flat here run from factory flat each time - so can compare
%daily change
dm = Alpao97_15_4th_Nov_20(); 
dm.Init();
dm.Flatten();

%% Register the actuator positions with the Shack Hartman
%
%
% poke each actuator and record its location 
actLocations = zeros(97,2);
disp = 0.15;
%poke each actuator and record each max position as viewed by the Shack
%Hartman Wavefront Sensor
for act = 1:97
    dm.Poke(act, disp);
    phase = sh.CaptureImage();   
    imagesc(phase);
    drawnow();
    pause(0.5);
    [X,Y] = meshgrid(1:size(phase,2), 1:size(phase,1));
    X1 = X(:); Y1 = Y(:); phase1 = phase(:);
    [m, i] = max(phase1);
    x_i = X1(i);
    y_i = Y1(i);
    actLocations(act,:) = [y_i, x_i];
end

dm.Flatten();
% save out results of the actuator locations
save([szResults  'actLocations.mat'],'actLocations');
mat = matfile([szResults  'actLocations.mat']);
actLocations = mat.actLocations;
%plot then out as a sanity check
plot(actLocations(:,2), 35-actLocations(:,1),  'o');
labels = cellstr( num2str([1:97]') );
text(actLocations(:,2), 35-actLocations(:,1),labels,'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')

%%
% make the mirror as flat as this reference file which should be of a
% optically flat surface, I used lam/14 flat
sh.LoadReferenceFromFile('.\SHACK_HARTMAN\4_SHACK_HARTMAN\reference_flat_16_11_20.has');
%% Initialise the Flattening algorithm
%The Shack Hartman is in single pass
flatPhase = 0; %this was introduced earlier to account for the optics
best_act = zeros(1,97);
best_std = 99999;

acts = zeros(size(best_act)); %start with the actuators all zero
dm.SetActuators(acts);
colormap hot;
phase = sh.CaptureImage();
imagesc(phase);
colorbar;
title(sprintf('std dev : %dum \n', std(phase(~isnan(phase)))));
%% iterate the dm flattening algorithm
%
%
numIter = 20; % number of iterations
iterate = 1:numIter;
results = zeros(1,numIter);
appliedSurface = zeros(1,97);
numReps = 30;
creepDelay = 60; 
for iter = iterate
    % find the displacement at each actuator
    for k=1:97
       appliedSurface(k) = phase(actLocations(k, 1), actLocations(k, 2));   
    end
    appliedSurface(isnan(appliedSurface)) = 0;
    fact = -0.01; % take away 1 % for each iteration
    acts1 = acts + fact*appliedSurface;
    %set the DM
    dm.SetActuators(acts1);
    pause(creepDelay); %to allow fo thermal creep
    %take an average SH image
    resPhase = zeros(size(phase));
    for rep = 1:numReps
        resPhase = resPhase + sh.CaptureImage();
    end
    phase = resPhase/numReps;
    imagesc(phase);
    colorbar;
    title(sprintf('std dev : %dum\n', std(phase(~isnan(phase)))));
    drawnow();
    
    results(iter) = std(phase(~isnan(phase)));
    if std(phase(~isnan(phase))) < best_std
        best_acts = acts1;
        best_std = std(phase(~isnan(phase)));
    end
    acts = acts1;
    fprintf('iter %d, std dev %d\n', iter, std(phase(~isnan(phase))));
end
fprintf('best std: %d\n', best_std);
plot(iterate, results, 'o');
title('Best Flat');
xlabel('iteration');
ylabel('std dev of the surface (um)');
%% display and save off the best flat
% this then needs to be copied into the Alpao DM folder and reference added to
% the Alpao DM class

phase = sh.CaptureImage();
imagesc(phase);
colorbar;
std_dev = std(phase(~isnan(phase)));
pv = max((phase(~isnan(phase)))) - min((phase(~isnan(phase))));
title(sprintf('std dev : %dum,  p2v : %dum\n', std_dev, pv ));
save([szResults  'best_acts_' date '.mat'],'best_acts');

%% Shutdown
sh.Shutdown();  
dm.Shutdown();
unloadlibrary(winDLL);