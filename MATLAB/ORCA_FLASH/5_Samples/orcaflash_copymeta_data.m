%%matlab implementation of sdk:   copy meta_data
addpath('C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\4_Matlab');
%%
%%%NEEDS DEBUGGING USES VOID**
disp('COPY METADATA SAMPLE (PARTIAL)');

bRelay = true;
bDebug = false;

DCAM = DCAMSDK(bRelay, bDebug);
disp('loaded dcam');
%%
hdcam = dcamcon_init_open();
[err, hdcam, DCAM] = DCAM.dcamcon_init_open(bRelay, bDebug);
DCAM.dcamcon_show_dcamdev_info(DCAM, hdcam );
%%
waitOpen = C_DCAMWAIT_OPEN_(hdcam);
[err, waitOpen] = DCAM.dcamwait_open( waitopen );
clear waitOpen;
hwait = waitopen.hwait;
% allocate buffer
number_of_buffer = 10;
err = DCAM.dcambuf_alloc(hdcam, number_of_buffer );
% allocate the buffer for meta data
err = DCAM.dcamcap_start( hdcam, DCAM.DCAMCAP_START_SEQUENCE );
fprintf( '\nStart Capture\n' );
Sleep( 1000 );
DCAM.dcamcap_stop( hdcam );
fprintf( 'Stop Capture\n' );
show_framemetadata(DCAM,  hdcam, number_of_buffer );
DCAM.dcambuf_release( hdcam );
DCAM.dcamwait_close( hwait );
DCAM.dcamdev_close( hdcam );
dcamapi_uninit();

%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');