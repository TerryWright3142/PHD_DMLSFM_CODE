function [err, pixeltype, width, rowbytes, height] = get_image_information(DCAM, hdcam)
% brief	get image information from properties.
% param DCAM:       DCAM SDK object
% param	hdcam:		DCAM handle

    v = 0;
    [err, v] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_PIXELTYPE, v );
	if err < 0	
		return;	
	else
		pixeltype = int32(v);
        [err, v] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_WIDTH, v );
    
    
        if err < 0 
            return;
        else
            width = int32(v);
            [err, v] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_ROWBYTES, v );


            if err < 0 
                return;
            else
                rowbytes = int32(v);
                [err, v] = DCAM.dcamprop_getvalue( hdcam, DCAM.DCAM_IDPROP_IMAGE_HEIGHT, v );


                if err < 0 
                    return;
                else
                    height = int32(v);
                end
            end
        end
    end

end