function [bRet, buf] =  copy_targetarea(DCAM, bCopy,  hdcam, iFrame,  rowbytes, ox, oy, cx, cy ) 
% copy_targetarea  Copies a rect region on the frame buffer 

    bufframe = C_DCAMBUF_FRAME_(iFrame);
    % prepare buffer for ROI
  
      
    if bCopy == true
    % the memory allocated by MATLAB will be passed to DCAM to
    % be copied, the copying takes place inside the camera
                bufframe.buf		= uint16(zeros(cy,cx));
                bufframe.rowbytes	= rowbytes;
                bufframe.left		= ox;
                bufframe.top		= oy;
                bufframe.width		= cx;
                bufframe.height		= cy; 
                bufframe.MakePtr();
                err = DCAM.dcambuf_copyframe( hdcam, bufframe );
                if err < 0
                    bRet = false;
                    clear bufframe;
                    return;
                end
                buf = bufframe.buf; %not the most efficient way to transfer data
    else
    %the frame buffer will be locked on the camera a pointer passed
    %through to DCAM and then to MATLAB via a libpointer, copy the pixels
    %across
                [err, bufframe] = DCAM.dcambuf_lockframe( hdcam, bufframe );
                if err < 0
                    bRet = false;
                    clear bufframe;
                    return;
                end

                if bufframe.type ~= DCAM.DCAM_PIXELTYPE_MONO16
                            disp( 'not implement pixel type' );
                            bRet = false;
                            clear bufframe;
                            return;
                end

                % using pointer arithmetic on the underlying libpointer (not very nice)
                pixel_buf = libpointer('uint16Ptr', bufframe.buf);             
                setdatatype(pixel_buf, 'uint16Ptr', 1, bufframe.width*bufframe.height);
                pixel_buf = pixel_buf + oy * bufframe.rowbytes + ox;                    

                for y = 1 : cy
                    buf(y, :) = pixel_buf.Value(1:cx);
                    if y < (cy - 1)
                        pixel_buf = pixel_buf + bufframe.width;
                    end
                end
    
    end
	bRet = true;
    clear bufframe;
end