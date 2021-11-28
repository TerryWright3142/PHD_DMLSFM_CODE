%OrcaFlash demo script
bRelay = false; %so functions are called directly from DCAMAPI
flash = OrcaFlash(bRelay);
flash.Init();
%% capture with roi
[err, im] = flash.CaptureImage(1,0,0,100,100);
%% capture all fov
[err, im] = flash.CaptureImage(1);
%% 
imagesc(im);
%%
err = flash.SetRect(0,0,128, 128);
[err, im] = flash.CaptureImage(1);
[err, rate] = flash.GetFrameRate();
rate
%these functions do reduce the size that is captured but do not seem to
%pass on the high frame rate
%so at the moment they do not work

%%
err = flash.SetExposureTime(0.0007); %it doesnt set it to this but the next legal value which is 0.001

%% save the image as a tiff
imwrite(im, 'orca_flash_test.tiff');

%% 
flash.Shutdown();
clear flash