%%matlab implementation of sdk:   open_show_modelinfo
% ok 29/12/17
disp('OPEN_SHOW_MODELINFO SAMPLE');
addpath('../4_Matlab');
bRelay = true;
bDebug = false;

DCAM = DCAMSDK(bRelay, bDebug);
disp('loaded dcam');
DCAM.setDebug(false);

%% init dcam sdk
data = C_INT32_ARRAY_();
guid = C_DCAM_GUID_();
init = C_DCAMAPI_INIT_(0,0,data.SizeOf(), data, guid);
[err, init] = DCAM.dcamapi_init(init);
err
clear init guid data;
disp('dcamapi_init');

%% OPEN CAMERA
deviceToUse = 0;
open = C_DCAMDEV_OPEN_(deviceToUse);
[err, open] = DCAM.dcamdev_open(open);
err
hdcam = open.GetHDCAM();
clear open;
disp('dcamdev_open');


%% CLOSE CAMERA
DCAM.dcamdev_close(hdcam)
disp('dcamdev_close');
%% uninit dcam sdk
DCAM.dcamapi_uninit()
disp('dcamapi_uninit');
%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');