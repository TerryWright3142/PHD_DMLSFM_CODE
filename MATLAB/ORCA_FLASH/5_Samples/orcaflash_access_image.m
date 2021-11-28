%%matlab implementation of sdk:   access_image

% just displays the image rather than find average value
disp('ACCESS_IMAGE SAMPLE (PARTIAL)');
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

%% SHOW DEVICE INFO
sz(1) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_MODEL,[char(32*ones(1,300)) 0]); 
sz(2) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_CAMERAID,[char(32*ones(1,300)) 0]); 
sz(3) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_BUS,[char(32*ones(1,300)) 0]); 
for f = 1:3
    [err, sz(f)] = DCAM.dcamdev_getstring(hdcam, sz(f));
    
end
disp('DEVICE INFO:');
disp(['model=' sz(1).text]);
disp(['cameraid=' sz(2).text]);
disp(['bus=' sz(3).text]);

clear sz;

%%  OPEN HDCAMWAIT HANDLE TO WAIT FOR EVENTS
wait = C_DCAMWAIT_OPEN_(0, 0, hdcam);
[err, wait] = DCAM.dcamwait_open(wait);
err
hwait = wait.GetHWAIT();
clear wait;
disp('dcamwait_open');

%% allocate the frame buffer
framecount = 1;
DCAM.dcambuf_alloc(hdcam, framecount)
disp('dcambuf_alloc');

%% start capture
mode = DCAM.DCAMCAP_START_SEQUENCE; 
DCAM.dcamcap_start(hdcam, mode)
disp('dcamcap_start');

%% start the wait for the frame to be captured
timeout = 1000;
waitStart = C_DCAMWAIT_START_(0, DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout);
[err, waitStart] = DCAM.dcamwait_start(hwait, waitStart);
err
clear waitStart;
disp('dcamwait_start');



%% end capture
DCAM.dcamcap_stop(hdcam)
disp('dcamcap_stop');

%% transfer info about captured image
transfer = C_DCAMCAP_TRANSFERINFO_();
[err, transfer] = DCAM.dcamcap_transferinfo(hdcam, transfer);
err
disp('dcamcap_transferinfo');
disp(['Frame Count=' num2str(transfer.nFrameCount)]);
clear transfer;
%% print out some info about the captured images
queries = [DCAM.DCAM_IDPROP_IMAGE_PIXELTYPE, DCAM.DCAM_IDPROP_IMAGE_WIDTH,DCAM.DCAM_IDPROP_IMAGE_HEIGHT, DCAM.DCAM_IDPROP_IMAGE_ROWBYTES];
results = zeros(1,4);
for f = 1:4
    [err, results(f)] = DCAM.dcamprop_getvalue(hdcam, queries(f), results(f)); 
end
pixeltype = int32(results(1));
obj.imageWidth = int32(results(2));
obj.imageHeight = int32(results(3));
rowbytes = int32(results(4));
disp(['width=' num2str(obj.imageWidth)]);
disp(['height=' num2str(obj.imageHeight)]);
disp(['rowbytes=' num2str(rowbytes)]);

%% lock target area on frame and get a buffer to the pixels

iFrame = 0; %% could sample and process each frame
buffer = C_DCAMBUF_FRAME_(iFrame);
[err, bufframe] = DCAM.dcambuf_lockframe(hdcam, buffer);
err
pixel_buf = libpointer('uint16Ptr', bufframe.buf);             
setdatatype(pixel_buf, 'uint16Ptr',  bufframe.width, bufframe.height);
clear buffer;
disp('dcambuf_lockframe');


%% draw the pixels
pixels = pixel_buf.Value;
imagesc(pixels);


%% release the frame buffer
ikind = DCAM.DCAM_DEFAULT_ARG;
DCAM.dcambuf_release(hdcam, ikind)
disp('dcambuf_release');
%% CLOSE HDCAMWAIT HANDLE
DCAM.dcamwait_close(hwait)
disp('dcamwait_close');
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

    

