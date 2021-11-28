%%matlab implementation of sdk:   init_uninit
% OK 29/12/17
disp('INIT_UNIT SAMPLE');
addpath('../4_Matlab');
bRelay = true;
bDebug = false;

DCAM = DCAMSDK(bRelay, bDebug);
disp('loaded dcam');


%% init dcam sdk
data = C_INT32_ARRAY_();
guid = C_DCAM_GUID_();
init = C_DCAMAPI_INIT_(0,0,data.SizeOf(), data, guid);
[err, init] = DCAM.dcamapi_init(init);
clear init guid data;
err



%% uninit dcam sdk
DCAM.dcamapi_uninit()
disp('dcamapi_uninit');
%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');