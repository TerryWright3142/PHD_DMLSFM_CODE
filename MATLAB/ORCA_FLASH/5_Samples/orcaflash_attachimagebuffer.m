%sample: attach image buffer
addpath('../4_Matlab');
bRelay = true;
bDebug = false;
%%
[err, hdcam, DCAM] = dcamcon_init_open(bRelay, bDebug);
dcamcon_show_dcamdev_info(DCAM, hdcam );
%%
waitopen = C_DCAMWAIT_OPEN_(0, 0, hdcam);
[err, waitopen] = DCAM.dcamwait_open(waitopen );
hwait = waitopen.GetHWAIT();
clear waitopen;
%% 
bufframebytes = 0;
[err, bufframebytes] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_BUFFER_FRAMEBYTES, bufframebytes);
number_of_frames = 10;
buffer = uint8(zeros(1, number_of_frames*bufframebytes));
attach = C_DCAMBUF_ATTACH_(DCAM.DCAMBUF_ATTACHKIND_FRAME, buffer, number_of_frames);
[err, attach] = DCAM.dcambuf_attach(hdcam, attach);
disp('made buffer to store all frames');
%%
mode = DCAM.DCAMCAP_START_SEQUENCE; 
err = DCAM.dcamcap_start( hdcam, mode );
fprintf( "\nStart Capture\n" );
%% 
f= 0;
[err, topoffset] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_BUFFER_TOPOFFSETBYTES, f);
[err, rowbytes] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_BUFFER_ROWBYTES, f);
[err, pixeltype] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_BUFFER_PIXELTYPE, f);
[err, width] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_WIDTH, f);
[err, height] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_HEIGHT, f);
%%
count = 0
while count < number_of_frames
    timeout = 1000;
    waitStart = C_DCAMWAIT_START_(0, DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout);
    [err, waitStart] = DCAM.dcamwait_start(hwait, waitStart);
    clear waitStart;
    if err == DCAM.DCAMERR_ABORT
        break;
    end
    transfer = C_DCAMCAP_TRANSFERINFO_();
    [err, transfer] = DCAM.dcamcap_transferinfo(hdcam, transfer);
    disp(['Frame Count=' num2str(transfer.nFrameCount)]);
    disp(['Frame New=' num2str(transfer.nNewestFrameIndex)]);
    clear transfer;
    count = count + 1;
    
end


%% do we have all of the frames

%stop capture
DCAM.dcamcap_stop( hdcam );
fprintf( "Stop Capture\n" );
%% access image
attach.Refresh();
buffer = attach.GetPtr().Value.buffer;
clear attach;
%%
buffer = typecast(buffer, 'uint16');
buffer = reshape(buffer, height, width, number_of_frames);

for i=1:10
    imagesc(buffer(:,:,i));
    pause(0.5);
end

%% 
ikind = DCAM.DCAM_DEFAULT_ARG;
DCAM.dcambuf_release( hdcam, ikind );
DCAM.dcamwait_close( hwait );
DCAM.dcamdev_close( hdcam );
DCAM.dcamapi_uninit();
clear DCAM;
disp('shutdown');

