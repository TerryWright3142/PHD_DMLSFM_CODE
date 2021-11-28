%EXP_13_1_21_DMLSFM_SCAN_SLAVE

%controls and instantiates the OrcaFlash responds to the camera triggers
%from the NI DAQ 6363 and aquires a stack of images at the moment
%continuously saves over the same images

addpath('..\');
addpath('C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\4_Matlab');
%include win_mutex.dll with timing primitives
dllFolder = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
libfunctions(winDLL);
INFINITE           = hex2dec('FFFFFFF');
calllib(winDLL, 'Win_InitSpeechEngine');
%
%
%open memory map
mem_map = cMMap('test.dat');
mem_map.OpenMap(); 
%
%
%folder for volume scan images
szResults = '20.3.3_pollen_volume\';
mkdir(szResults);
%
%
%
%initialise Flash
flash = InitialiseFlash(mem_map);
[~, im] = flash.CaptureImage(1); 
imagesc(im);
drawnow();
%configure TRIGGER GLOBAL EXPOSURE    GLOBAL RESET
bRollingShutter = false;
ConfigureShutterFlash(flash, bRollingShutter);
%configure input trigger from the DM
ConfigureInputTriggerFlash(flash, mem_map);
%
%
%
%inform the master that the slave is running
mem_map.Set_bSlaveRunning(1);
%Now both the master and the slave are running
%%

% check for race condition

%wait for master: spinning

%to exit shut down the slave first when you want to stop  - otherwise it will be waiting in the DCAM.dll
%for images and result in deadlock 
while ~(mem_map.Get_slave_state==0)
    ;
end 
 %img_cnt = 1;
 while true
        %capture images for this volume
        [im, ~] = FlashAquireImages(flash, mem_map.num_exposures, 0, mem_map);
        %save the volume
        for f = 1 : size(im, 3)
           %can continuously index images - but will fill up memory
           %very quickly
           %imwrite(im(:,:,f), [szResults '/' num2str(img_cnt) '.tiff']);  
           %img_cnt  = img_cnt + 1;

           %or just the same slices
           %which is OK since we are not really using it for
           %biology 
           imwrite(im(:,:,f), [szResults '/' num2str(f) '.tiff']); 
        end           
    end  

%% Shutdown
flash.Shutdown();
unloadlibrary(winDLL);
disp('Shutdown');
clear;




