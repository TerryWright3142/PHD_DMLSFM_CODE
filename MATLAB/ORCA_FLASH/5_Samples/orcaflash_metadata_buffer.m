%% matlab implementation of SDK:  metadata_buffer

% ALLOCATING VOID** ARRAYS OF POINTERS AND STRUCT ARRAYS
disp('METADATA_BUFFER SAMPLE');
addpath('../4_Matlab');
bRelay = true;
bDebug = false;

DCAM = DCAMSDK(bRelay, bDebug);
disp('loaded dcam');
DCAM.setDebug(false);

attach_primarybuffer =	1	% 0: attach pointer array to store meta data, 1: attach primary buffer to store meta data

[err, hdcam, DCAM] = dcamcon_init_open(bRelay, bDebug);
dcamcon_show_dcamdev_info(DCAM, hdcam );
waitOpen = C_DCAMWAIT_OPEN_(hdcam);
[err, waitOpen] = DCAM.dcamwait_open( waitopen );
clear waitOpen;
hwait = waitopen.hwait;
% allocate buffer
number_of_buffer = 10;
err = DCAM.dcambuf_alloc(hdcam, number_of_buffer );
% allocate the buffer for meta data
number_of_metadata = 100;
timestamp_array(number_of_metadata) = C_DCAM_TIMESTAMP_();
framestamp_array(number_of_metadata) = int32(0);
if attach_primarybuffer
% attach primary buffer for meta data
    attach_primary_timestampbuffer( DCAM, hdcam, timestamp_array, number_of_metadata );
    attach_primary_framestampbuffer( DCAM, hdcam, framestamp_array, number_of_metadata );
else
    % prepare pointer array to store pointer of meta data
    % how do I do this
    void** pTimeStamp	= new void*[ number_of_metadata ];
    void** pFrameStamp	= new void*[ number_of_metadata ];

    % pointer algebra
    for  i = 0 :  (number_of_metadata-1)
        pTimeStamp(i)	= timestamp_array + i;
        pFrameStamp(i)	= framestamp_array + i;
    end
    % attach buffer pointer array for meta data
    attach_timestampbuffer(DCAM, hdcam, pTimeStamp, number_of_metadata );
    attach_framestampbuffer(DCAM, hdcam, pFrameStamp, number_of_metadata );
end

% start capture
err = DCAM.dcamcap_start( hdcam, DCAM.DCAMCAP_START_SEQUENCE );
fprintf( "\nStart Capture\n" );
% stop capture
DCAM.dcamcap_stop( hdcam );
fprintf( "Stop Capture\n" );
show_metadata_information(DCAM, hdcam, number_of_metadata, timestamp_array, framestamp_array );
if attach_primarybuffer
else
	clear pTimeStamp pFrameStamp;
end

clear timestamp_array framestamp_array;
DCAM.dcambuf_release( hdcam );
DCAM.dcamwait_close( hwait );
DCAM.dcamdev_close( hdcam );
dcamapi_uninit();

%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');

