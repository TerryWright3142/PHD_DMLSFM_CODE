%% OrcaFlash Test Script
% OK 15/12

bRelay = false; 
% set bRelay to false to directly use DCAM.dll, true 
% sends commands through R_DCAM.dll to intercept and modify parameters
% before then sending off to DCAM.dll

OrcaFlash.InitDCAM(bRelay); %load up DLL into address space
camera = OrcaFlash(bRelay); %make OrcaFlash with Camera interface
camera.Init();              %creates main DCAM handles
A = camera.CaptureImage(); %get pixels as a matrix
%camera.DrawImage();        %draw single image        
%camera.DrawImages();        % need to ctr c to break out of loop and run last 2 lines
%% 
camera.Shutdown();          %release DCAM handles
OrcaFlash.ReleaseDCAM(bRelay); %remove DLL from process address space


imagesc(A);
