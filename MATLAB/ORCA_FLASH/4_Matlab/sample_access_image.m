function err = sample_access_image( DCAM, hdcam, bCopyFrame )
% brief	sample used to process image after capturing.
% details	This function copies the target area that is 1% of full area on the center.
% param DCAM:  DCAM SDK object
% param	hdcam:	DCAM handle
% param bCopyFrame  copy the pixels on the camera rather than locking 

	transferinfo = C_DCAMCAP_TRANSFERINFO_();
	% get number of captured image
	[err, transferinfo] = DCAM.dcamcap_transferinfo( hdcam, transferinfo );
	if err < 0 
        clear transferinfo;
        return;
    end
	if transferinfo.nFrameCount < 1 	
        fprintf( 'not capture image\n' );
        clear transferinfo;
		return;
    end
	% get image information
	[err, pixeltype, width, rowbytes, height] = get_image_information( DCAM, hdcam);
	if pixeltype ~= DCAM.DCAM_PIXELTYPE_MONO16 	
		fprintf( 'not implement\n' );
        clear transferinfo;
		return;
    end

    cx = width ;%/ 10;
    cy = height ;% / 10;
    if( cx < 10 ),	cx = 10;, end
    if( cy < 10 ),	cy = 10;, end
% 	if  cx > width || cy > height 	
% 		fsprintf( 'frame is too small\n' );
%         clear transferinfo;
% 		return;
%     end
    ox = 0;% (width - cx) / 2;
    oy = 0;% (height - cy) / 2;
	for iFrame = 0: (transferinfo.nFrameCount - 1)
		% copy image
		[bRet, buf] = copy_targetarea( DCAM, bCopyFrame, hdcam, iFrame, cx * 2, ox, oy, cx, cy );	
		% process image
        if bRet
            imagesc(buf);
        end		
    end
    clear transferinfo;
end

	