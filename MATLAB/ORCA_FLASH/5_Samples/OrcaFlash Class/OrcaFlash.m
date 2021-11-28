classdef OrcaFlash < OrcaFlashBase & Camera
    properties  

        exposureTime
        imageWidth
        imageHeight
        image
        bTrace
        background
        numImages      

        bRelay;
        hdcam
        hwait
        open
    end
    methods 
        function obj = OrcaFlash(bRelay)
           obj.bRelay = bRelay;
        end
        function Init(obj)
%             %open 1st camera - change when more cameras attached - in cstr
            deviceToUse = 0;
            open = C_DCAMDEV_OPEN_(deviceToUse);
            if obj.bRelay
                ret = calllib('R_DCAM', 'Dcamdev_open', open.GetPtr(), false);
            else
                ret = calllib('DCAM', 'dcamdev_open', open.GetPtr()) ;  
            end
            open.Refresh();
            obj.hdcam = open.GetHDCAM();
            % SHOW DEVICE INFO
            sz(1) = C_DCAMDEV_STRING_(obj.DCAM_IDSTR_MODEL,[char(32*ones(1,300)) 0]); 
            sz(2) = C_DCAMDEV_STRING_(obj.DCAM_IDSTR_CAMERAID,[char(32*ones(1,300)) 0]); 
            sz(3) = C_DCAMDEV_STRING_(obj.DCAM_IDSTR_BUS,[char(32*ones(1,300)) 0]); 
            for f = 1:3
                if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamdev_getstring', obj.hdcam, sz(f).GetPtr(), false);  %caused by size being wrong, get the struct size from sizeof()
                else
                    ret = calllib('DCAM', 'dcamdev_getstring', obj.hdcam, sz(f).GetPtr());  %caused by size being wrong, get the struct size from sizeof()   
                end
                sz(f).Refresh();
            end
            disp('DEVICE INFO:');
            disp(['model=' sz(1).text]);
            disp(['cameraid=' sz(2).text]);
            disp(['bus=' sz(3).text]);


            %  OPEN HDCAMWAIT HANDLE TO WAIT FOR EVENTS
            wait = C_DCAMWAIT_OPEN_(0, 0, obj.hdcam);
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamwait_open', wait.GetPtr(), false);
            else

                    ret = calllib('DCAM', 'dcamwait_open', wait.GetPtr());
            end
            wait.Refresh();
            obj.hwait = wait.GetHWAIT();



          
        end
        function Shutdown(obj)
            %RELEASE THE ALLOCATED BUFFER
            iKind = obj.DCAM_DEFAULT_ARG;
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcambuf_release', obj.hdcam, iKind, false);
            else

                    ret = calllib('DCAM', 'dcambuf_release', obj.hdcam, iKind);
            end
            %CLOSE HDCAMWAIT HANDLE
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamwait_close', obj.hwait, false);
            else
                    ret = calllib('DCAM', 'dcamwait_close', obj.hwait);
            end
            if ret<0
                disp('failed at dcamwait_close');
            end
            % CLOSE HDCAM HANDLE TO THE CAMERA
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamdev_close', obj.hdcam, false);
            else
                    ret = calllib('DCAM', 'dcamdev_close', obj.hdcam);
            end
        end 
        function SetExposure(obj, v)
            disp('not yet implemented use HCI');
      
        end
        function im = CaptureImage(obj)  
            framecount = 1;
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcambuf_alloc', obj.hdcam, framecount, false);
            else

                    ret = calllib('DCAM', 'dcambuf_alloc', obj.hdcam, framecount);
            end
            % START CAPTURE
            mode = obj.DCAMCAP_START_SEQUENCE;       
            if obj.bRelay
                ret = calllib('R_DCAM', 'Dcamcap_start', obj.hdcam, mode, false);
            else

                ret = calllib('DCAM', 'dcamcap_start', obj.hdcam, mode);
            end
            % WAITSTART
            timeout = 1000;
            waitStart = C_DCAMWAIT_START_(0, obj.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout);
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamwait_start', obj.hwait, waitStart.GetPtr(), false);
            else

                    ret = calllib('DCAM', 'dcamwait_start', obj.hwait, waitStart.GetPtr());
            end
            waitStart.Refresh();
            %eventhappened should tell us what happened 
            % STOP CAPTURE
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamcap_stop', obj.hdcam, false);
            else   
                    ret = calllib('DCAM', 'dcamcap_stop', obj.hdcam);
            end
            % TRANSFER INFO ABOUT THE CAPTURED IMAGE
            transfer = C_DCAMCAP_TRANSFERINFO_();
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcamcap_transferinfo', obj.hdcam, transfer.GetPtr(), false);
            else   
                    ret = calllib('DCAM', 'dcamcap_transferinfo', obj.hdcam, transfer.GetPtr());
            end
            transfer.Refresh();
            %disp(['Frame Count=' num2str(transfer.nFrameCount)]);
            
            queries = [obj.DCAM_IDPROP_IMAGE_PIXELTYPE, obj.DCAM_IDPROP_IMAGE_WIDTH, obj.DCAM_IDPROP_IMAGE_HEIGHT, obj.DCAM_IDPROP_IMAGE_ROWBYTES];
            results = zeros(1,4);
            for f = 1:4
                if obj.bRelay
                    x = libpointer('doublePtr', results(f));
                    ret = calllib('R_DCAM', 'Dcamprop_getvalue', obj.hdcam, queries(f), x , false);
                    results(f) = x.Value();
                else
                    x = libpointer('doublePtr', results(f));
                    ret = calllib('DCAM', 'dcamprop_getvalue', obj.hdcam, queries(f), x , false); % fqalse at end? bug?
                    results(f) = x.Value();
                end    
            end
            pixeltype = int32(results(1));
            obj.imageWidth = int32(results(2));
            obj.imageHeight = int32(results(3));
            rowbytes = int32(results(4));
%             disp(['width=' num2str(obj.imageWidth)]);
%             disp(['height=' num2str(obj.imageHeight)]);
%             disp(['rowbytes=' num2str(rowbytes)]);

            % LOCK TARGET AREA (WHOLE FRAME) AND GET BUFFER TO PIXELS
            iFrame = 0; %% could sample and process each frame
            buffer = C_DCAMBUF_FRAME_(iFrame);

            if obj.bRelay
                ret = calllib('R_DCAM', 'Dcambuf_lockframe', obj.hdcam, buffer.GetPtr(),  false);
            else
                ret = calllib('DCAM', 'dcambuf_lockframe', obj.hdcam, buffer.GetPtr());
            end 
            buffer.Refresh();
            pixel_buf = buffer.GetPtr().Value.buf;

            % tmp.DataType gives 'voidPtr' we need to cast it to the right type and the
            % right size
            setdatatype(pixel_buf, 'uint16Ptr', buffer.width,buffer.height); %this acts in place
            
          
            %pixel_buf.Value gives a vector of all of the pixel values
            %now cast to a matrix
            im = pixel_buf.Value;
            %RELEASE THE BUFFER
           
            iKind = obj.DCAM_DEFAULT_ARG;
            if obj.bRelay
                    ret = calllib('R_DCAM', 'Dcambuf_release', obj.hdcam, iKind, false);
            else

                    ret = calllib('DCAM', 'dcambuf_release', obj.hdcam, iKind);
            end
          
        
        end
        function im = CaptureBackground(obj, num)
            disp('not yet implemented');                  
        end
        function DrawImage(obj)
           imagesc(obj.CaptureImage());
           drawnow();
        end
        function DrawImages(obj)
            while true
                obj.DrawImage();
            end
        end
        function Trace(obj)
            disp('not yet implemented');
        end
    end


end