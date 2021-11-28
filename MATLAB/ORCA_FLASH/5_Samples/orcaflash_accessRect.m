%%matlab implementation of sdk:  orcaflash_accessRect

%works OK but why did it only capture 1 and not 10?

%Other than that working 1/1/18
disp('ACCESS_IMAGE SAMPLE (FULL)');
addpath('../4_Matlab');
bCopyFrame = true;
bRelay = true;
bDebug = false;
[err, hdcam, DCAM] = dcamcon_init_open(bRelay, bDebug);
  
if err >=0 && hdcam ~= 0
    % show device information
    dcamcon_show_dcamdev_info(DCAM, hdcam );
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SENSORMODE, DCAM.DCAMPROP_SENSORMODE__AREA);
    if (err<0),dcamcon_show_dcamerr(err), end
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SUBARRAYMODE, DCAM.DCAMPROP_MODE__ON);
    if (err<0), dcamcon_show_dcamerr(err), end;
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SUBARRAYHPOS, 1000);
    if (err<0), dcamcon_show_dcamerr(err), end;
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SUBARRAYVPOS, 1000);
    if (err<0), dcamcon_show_dcamerr(err), end;
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SUBARRAYHSIZE, 128);
    if (err<0), dcamcon_show_dcamerr(err), end;
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_SUBARRAYVSIZE, 128);
    if (err<0), dcamcon_show_dcamerr(err), end;

    val = 0.0;
    [err, val] = DCAM.dcamprop_getvalue(hdcam, DCAM.DCAM_IDPROP_INTERNALFRAMERATE, 0.0);
    if (err<0), dcamcon_show_dcamerr(err), end;
    val
    % the ranges of the exposure time have now changed
    %
    val = 0.0007;
    err = DCAM.dcamprop_setvalue(hdcam, DCAM.DCAM_IDPROP_EXPOSURETIME, val);
    if (err<0), dcamcon_show_dcamerr(err), end;
    
    val = 0;
    [err, val] = DCAM.dcamprop_getvalue(hdcam, DCAM.DCAM_IDPROP_EXPOSURETIME, val);
    val %cant get below 0.001
    
    val = 0.0;
    [err, val] = DCAM.dcamprop_getvalue(hdcam, DCAM.DCAM_IDPROP_INTERNALFRAMERATE, 0.0);
    if (err<0), dcamcon_show_dcamerr(err), end;
    val
    


    % open wait handle
    waitopen = C_DCAMWAIT_OPEN_(0, 0, hdcam);
    [err, waitopen] = DCAM.dcamwait_open(waitopen );
    hwait = waitopen.GetHWAIT();
    clear wait;
    if err < 0
        dcamcon_show_dcamerr( DCAM, hdcam, err, "dcamwait_open()" );
    else	
        % allocate buffer
        number_of_buffer = 10;
        err = DCAM.dcambuf_alloc( hdcam, number_of_buffer );
        if( err < 0 )		
            dcamcon_show_dcamerr( hdcam, err, "dcambuf_alloc()" );
        else
			% start capture
            mode = DCAM.DCAMCAP_START_SEQUENCE; 
			err = DCAM.dcamcap_start( hdcam, mode );
            if  err < 0
                dcamcon_show_dcamerr( hdcam, err, "dcamcap_start()" );
            else
				fprintf( "\nStart Capture\n" );
                timeout = 1000;
                waitStart = C_DCAMWAIT_START_(0, DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout);
                [err, waitStart] = DCAM.dcamwait_start(hwait, waitStart);
                clear waitStart;
                % wait image
				if err < 0
					dcamcon_show_dcamerr( hdcam, err, "dcamwait_start()" );
                else
                    %stop capture
                    DCAM.dcamcap_stop( hdcam );
                    fprintf( "Stop Capture\n" );
                    %access image
                    fprintf( "Access Image\n" );
                    sample_access_image(DCAM, hdcam, bCopyFrame );
                end
            end
            % release buffer
            ikind = DCAM.DCAM_DEFAULT_ARG;
            DCAM.dcambuf_release( hdcam, ikind );
        end

        % close wait handle
        DCAM.dcamwait_close( hwait );
    end

    % close DCAM handle
    DCAM.dcamdev_close( hdcam );
end
%advice is that you always uninit
DCAM.dcamapi_uninit();
clear DCAM;
disp('unloaded dcam');
fprintf( "PROGRAM END\n" );


 
