function err = dcamcon_show_dcamerr( DCAM, hdcam, idStr, fnSz )
% dcamcon_show_dcamerr  display an error message for an error code
% param DCAM:  DCAM SDK object
% param hdcam:  hdcam handle
% param idStr:  id of the error
% param fnSz:   API that triggered the error
	param =  C_DCAMDEV_STRING_(idStr,[char(32*ones(1,300)) 0]);
	[err, param] = DCAM.dcamdev_getstring( hdcam, param );
    disp(strcat('ERROR:', fnSz, ':' , param.text));
end