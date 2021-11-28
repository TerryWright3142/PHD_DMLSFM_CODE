%THIS SCRIPT ALLOWS INDIVIDUAL STRUCTURES AND RELAY DLL TO BE TESTED
%script relay parameter function test
%%init dll
DCAM = DCAMSDK(true, true);
disp('loaded dcam');

%% dcamdev_getcapability
disp('dcamdev_getcapability');
caps = C_DCAMDEV_CAPABILITY_(DCAM.DCAMDEV_CAPDOMAIN__FUNCTION, 0, 0);
hdcam = 999;
DCAM.dcamdev_getcapability(hdcam, caps);
disp(caps.capflag);
clear caps;
% DEBUG OK 29/12

%% dcamprop_getattr
disp('dcamprop_getattr');
attr = C_DCAMPROP_ATTR_(DCAM.DCAMPROP_ATTR_READABLE);
hdcam = 999;
DCAM.dcamprop_getattr(hdcam, attr);
attr
clear attr;

% debug 0k 29/12
%% dcamprop_setvalue
disp('dcamprop_setvalue');
hdcam = 999;
DCAM.dcamprop_setvalue(hdcam, 1, 2.999);

% debug OK 29.12

%% dcamprop_getvalue
disp('dcamprop_getvalue');
hdcam = 999;
iProp = 10;
v = 0;
[err, v] = DCAM.dcamprop_getvalue(hdcam, iProp, v);
v

% debug OK 4/1/18
%% dcamprop_setgetvalue
disp('dcamprop_setgetvalue');
hdcam = 999;
iProp = 4;
pValue = 1.234;
option = 5;
[err, pValue] = DCAM.dcamprop_setgetvalue(hdcam, iProp, pValue, option);
disp(pValue);


% debug OK 29.12

%% dcamprop_queryvalue
hdcam = 999;
iProp = 4;
pValue = 1.234;
option = 5;
[err, pValue] = DCAM.dcamprop_queryvalue(hdcam, iProp, pValue, option);
disp(pValue);

% debug OK 29.12
%% dcamprop_getnextid
hdcam = 999;
pProp = 4;
option = 5;
[err, pProp] = DCAM.dcamprop_getnextid(hdcam, pProp, option);
disp(pProp);


% debug OK 29.12

%% dcamprop_getname
hdcam = 999;
iProp = 1;
text = ['1234567890' 0];
textbytes = length(text);
[err, text] = DCAM.dcamprop_getname(hdcam, iProp, text, textbytes);
text

% debug OK 29.12
%% dcamprop_getvaluetext
disp('dcamprop_getvaluetext');
hdcam = 999;
iProp = 1;
value = 2;
text = int8(['123456789' 0]);
textbytes = length(text);
valueText = C_DCAMPROP_VALUETEXT_(iProp, value, text, textbytes); 
[err, valueText] = DCAM.dcamprop_getvaluetext(hdcam, valueText);
disp(char(valueText.text));

% debug OK 29.12

%% dcamdev_setdata
disp('dcamdev_setdata');
hdcam = 999;
iKind = 1;
option = 2;
reserved2 = 3;
data = C_DCAMDATA_HDR_(iKind, option, reserved2);
[err, data] = DCAM.dcamdev_setdata(hdcam, data);
disp(data.iKind);
disp(data.option);
disp(data.reserved2);
clear data;

% debug OK 29.12

%% dcamdev_getdata

disp('dcamdev_getdata');
hdcam = 999;
iKind = 1;
option = 2;
reserved2 = 3;
data = C_DCAMDATA_HDR_(iKind, option, reserved2);
[err, data] = DCAM.dcamdev_getdata(hdcam, data);
disp(data.iKind);
disp(data.option);
disp(data.reserved2);
clear data;

% debug OK 29.12

%% dcambuf_attach

    %find the buffer size in bytes
    bufframebytes = 0;
    %[err, bufframebytes] = DCAM.dcamprop_getvalue(hdcam, DCAM.DCAM_IDPROP_BUFFER_FRAMEBYTES, bufframebytes);
    bufframebytes = 6;
    number_of_frames = 10;
    buffer = uint8(zeros(1, number_of_frames*bufframebytes));
    hdcam = 999;
    attach = C_DCAMBUF_ATTACH_(0, buffer, number_of_frames);
    [err, attach] = DCAM.dcambuf_attach(hdcam, attach);
    attach.Refresh;
    attach.buffer
% debug OK 2/1/18
% the limitation is that 
clear attach;
%%%%%%%%%%%%%%%NOT OK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% dcambuf_copyframe
hdcam = 999;
iFrame = 1;
frame = C_DCAMBUF_FRAME_(iFrame);
[err, frame] = DCAM.dcambuf_copyframe(hdcam, frame);
pixel_buf = frame.GetPtr().Value.buf;
frame.width = 1;
frame.height = 5;
%change the pixel format
setdatatype(pixel_buf, 'int32Ptr', frame.width, frame.height); %this acts in place
pixels = pixel_buf.Value; 
pixels

% debug OK 30/12
%% dcambuf_copymetadata
hdcam = 999;
hdr = C_DCAM_METADATAHDR_(0,0,0);
[err, hdr] = DCAM.dcambuf_copymetadata(hdcam, hdr);
hdr
% debug OK 30/12                
%% dcamcap_status
hdcam = 999;
pStatus = 1;
[err, pStatus] = DCAM.dcamcap_status(hdcam, pStatus);

disp(pStatus);
 
% OK debug 30/12
%% dcamcap_firetrigger
hdcam = 999;
iKind = 2;
err = DCAM.dcamcap_firetrigger(hdcam, iKind);
% OK debug 30/12

%% dcamcap_record
hdcam = 999;
hrec = 0;

err = DCAM.dcamcap_record(hdcam, hrec);

disp(hrec);
% OK debug 30/12
%% dcamwait_abort
hwait = 0;

err = DCAM.dcamwait_abort(hwait);

% OK debug 30/12
%% dcamrec_open
disp('dcamrec_open');
reserved = 0; 
hrec = 0; 
path = int8(['hi there' 0]);
ext = int8(['hi again' 0]);
maxframepersession = 0;
userdatasize = 1;
userdatasize_session = 2;
userdatasize_file = 3;
usertextsize = 4;
usertextsize_session=5;
usertextsize_file = 6;
open = C_DCAMREC_OPEN_(reserved, hrec, path, ext, maxframepersession, userdatasize, ...
    userdatasize_session, userdatasize_file, usertextsize, usertextsize_session, ...
    usertextsize_file);
[err, open] = DCAM.dcamrec_open(open);


% OK debug 30/12
                
%% dcamrec_close
hrec = 5;
err = DCAM.dcamrec_close(hrec);

% OK debug 30/12
%% dcamrec_lockframe

disp('dcamrec_lockframe');
hrec = 5;
iFrame = 1;
frame = C_DCAMREC_FRAME_(iFrame);
[err, frame] = DCAM.dcamrec_lockframe(hrec, frame);
pixel_buf = frame.GetPtr().Value.buf;
frame.width = 1;
frame.height = 5;
%change the pixel format
setdatatype(pixel_buf, 'uint32Ptr', frame.width, frame.height); %this acts in place
pixels = pixel_buf.Value; 
pixels
% OK debug 30/12


%% dcamrec_copyframe
hrec = 5;
iFrame = 1;
frame = C_DCAMREC_FRAME_(iFrame);
[err, frame] = DCAM.dcamrec_copyframe(hrec, frame);
pixel_buf = frame.GetPtr().Value.buf;
frame.width = 1;
frame.height = 5;
%change the pixel format
setdatatype(pixel_buf, 'uint32Ptr', frame.width, frame.height); %this acts in place
pixels = pixel_buf.Value; 
pixels
% OK debug 30/12
%% dcamrec_writemetadata
hrec = 5;
hdr = C_DCAM_METADATAHDR_(0,0,0);

[err, hdr] = DCAM.dcamrec_writemetadata(hrec, hdr);

% OK 30/12
%% dcamrec_lockmetadata
hrec = 5;
hdr = C_DCAM_METADATAHDR_(0,0,0);

[err, hdr] = DCAM.dcamrec_lockmetadata(hrec, hdr);
% OK 30/12
%% dcamrec_copymetadata
disp("dcamrec_copymetadata");
hrec = 5;
hdr = C_DCAM_METADATAHDR_(0,0,0);

[err, hdr] = DCAM.dcamrec_copymetadata(hrec, hdr);
% OK 30/12

%% dcamrec_lockmetadatablock
disp("dcamrec_lockmetadatablock");
hrec = 5;
iKind = 0;
option = 1;
iFrame = 2;
in_count = 3;
outcount = 4;
block = C_DCAM_METADATABLOCKHDR_(iKind, option, iFrame, in_count, outcount);

[err, block] = DCAM.dcamrec_lockmetadatablock(hrec, block);
% OK 30/12
%% dcamrec_copymetadatablock
disp("dcamrec_copymetadatablock");
hrec = 5;
iKind = 0;
option = 1;
iFrame = 2;
in_count = 3;
outcount = 4;
block = C_DCAM_METADATABLOCKHDR_(iKind, option, iFrame, in_count, outcount);

[err, block] = DCAM.dcamrec_copymetadatablock(hrec, block);
% OK 30/12S
%% dcamrec_pause
hrec = 5;

err = DCAM.dcamrec_pause(hrec);
% OK 30/12
%% dcamrec_resume
hrec = 5;

err = DCAM.dcamrec_resume(hrec);
% OK 30/12
%% dcamrec_status
disp("dcamrec_status");
hrec = 5;
currentsession_index=1;
maxframecount_per_session=2;
currentframe_index=3;
missingframe_count = 4;
flags = 5;
totalframecount = 6;
reserved = 7;
status = C_DCAMREC_STATUS_(currentsession_index, maxframecount_per_session, currentframe_index, ...
                missingframe_count, flags, totalframecount, reserved);
[err, status] = DCAM.dcamrec_status(hrec, status);

% OK 30/12


%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');