classdef OrcaFlash < handle
    properties
        
        imageWidth;
        imageHeight;
        pixelType;
        rowBytes;
 
        bRelay
        hdcam;
        hwait;
        DCAM;
        bCopyMethod;
        expTime;
        
        bAttachedBuffer
        number_of_frames
        buffer;
        attach;
        
        bWaterCooled;
        

    end
    methods (Static)
        function ret = DrawAsynch()
            ret = 1;
        
        end
    end
    methods 
        function obj = OrcaFlash(bRelay)
            obj.bAttachedBuffer = false;
            obj.number_of_frames = 0;
            obj.buffer = [];
            
            obj.bRelay = bRelay;
            obj.hdcam = 0;
            obj.hwait = 0;
            obj.DCAM = 0; 
            obj.bCopyMethod = true;
            obj. expTime = 0;
            obj.bWaterCooled = false;
            
            if obj.bWaterCooled
                disp('FLASH MUST BE WATER COOLED CHECK THAT IT IS WATER COOLED!!!');
            end
 
        end
        function SetCopyMethod(obj, bCopy)
            obj.bCopyMethod = bCopy;
        end       
        function err = Init(obj)
            [err, obj.hdcam, obj.DCAM] = obj.dcamcon_init_open(obj.bRelay);
            if err < 0
                return
            end
            obj.dcamcon_show_dcamdev_info(obj.DCAM, obj.hdcam );
            waitopen = C_DCAMWAIT_OPEN_(0, 0, obj.hdcam);
            [err, waitopen] = obj.DCAM.dcamwait_open(waitopen );
            obj.hwait = waitopen.GetHWAIT();
            clear waitopen;
            if err < 0
                obj.dcamcon_show_dcamerr( obj.DCAM, obj.hdcam, err, "dcamwait_open()" );
                return;
            end   
            err = obj.GetExposureTime();
            if obj.bWaterCooled
                obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SENSORCOOLER, obj.DCAM.DCAMPROP_SENSORCOOLER__ON); 
            end
        end
        
        % TEST THIS
        function err = AttachBuffer(obj, number_of_frames)
         bufframebytes = 0;
        [err, bufframebytes] = obj.DCAM.dcamprop_getvalue( obj.hdcam, obj.DCAM.DCAM_IDPROP_BUFFER_FRAMEBYTES, bufframebytes);
        obj.number_of_frames = number_of_frames;
        obj.buffer = uint8(zeros(1, obj.number_of_frames*bufframebytes));
        obj.attach = C_DCAMBUF_ATTACH_(obj.DCAM.DCAMBUF_ATTACHKIND_FRAME, obj.buffer, obj.number_of_frames);
        [err, obj.attach] = obj.DCAM.dcambuf_attach(obj.hdcam, obj.attach);
     
        end
        function [err, buff] = CaptureImages(obj)
            mode = obj.DCAM.DCAMCAP_START_SEQUENCE; 
            err = obj.DCAM.dcamcap_start( obj.hdcam, mode );
            timeout = 1000;
            waitStart = C_DCAMWAIT_START_(0, obj.DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout);
            for i = 1:obj.number_of_frames
                [err, waitStart] = obj.DCAM.dcamwait_start(obj.hwait, waitStart);
            end
            clear waitStart; 
            %stop capture
            obj.DCAM.dcamcap_stop( obj.hdcam );
            obj.attach.Refresh();
            obj.buffer = obj.attach.GetPtr().Value.buffer;
            buff = typecast(obj.buffer, 'uint16');
            buff = reshape(buff, obj.imageHeight, obj.imageWidth, obj.number_of_frames); %either recasting a pointer, or copying memory
        end
        function err = ReleaseBuffer(obj)
            ikind = obj.DCAM.DCAM_DEFAULT_ARG;
            err = obj.DCAM.dcambuf_release( obj.hdcam, ikind ); 
            obj.attach.delete();
            obj.attach = 0;
            
        end
        function err = SetRect(obj, ox, oy, cx, cy)
            %irregular/not working 14/4/19
            %NB the order of these commands seems to matter
               err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SENSORMODE, obj.DCAM.DCAMPROP_SENSORMODE__AREA);
               if (err < 0)
                   return
               end
               err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SUBARRAYMODE, obj.DCAM.DCAMPROP_MODE__ON);
               if (err<0)
                   return 
               end

               obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SUBARRAYHSIZE, cx);
               obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SUBARRAYVSIZE, cy) ; 
               obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SUBARRAYHPOS, ox);
               obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_SUBARRAYVPOS, oy);

            
            
        end
        function GetTimeStampMeaning(obj)
             if obj.hdcam == 0
                err = 0;
                return;
             end   
              val = 0;
             [err, val] = obj.DCAM.dcamprop_getvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TIMESTAMP_PRODUCER , val);
             if val == obj.DCAM.DCAMPROP_TIMESTAMP_PRODUCER__NONE
                disp('timestamp not supported');
             elseif val == obj.DCAM.DCAMPROP_TIMESTAMP_PRODUCER__DCAMMODULE
                disp('TIMESTAMP is produced from DCAM.');
             elseif val == obj.DCAM.DCAMPROP_TIMESTAMP_PRODUCER__KERNELDRIVER
                disp('TIMESTAMP is produced from kernel driver.');
             elseif val ==  obj.DCAM.DCAMPROP_TIMESTAMP_PRODUCER__CAPTUREDEVICE
                disp('TIMESTAMP is produced from Frame Grabber.');
             elseif val ==  obj.DCAM.DCAMPROP_TIMESTAMP_PRODUCER__IMAGINGDEVICE
                disp('TIMESTAMP is produced from Camera.');
             else 
                 disp('error');         
             end
        end
        function GetFrameStampMeaning(obj)
             if obj.hdcam == 0
                err = 0;
                return;
             end   
              val = 0;
             [err, val] = obj.DCAM.dcamprop_getvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_FRAMESTAMP_PRODUCER , val);
             if val == obj.DCAM.DCAMPROP_FRAMESTAMP_PRODUCER__NONE
                disp('FRAMESTAMP not supported');
             elseif val == obj.DCAM.DCAMPROP_FRAMESTAMP_PRODUCER__DCAMMODULE
                disp('FRAMESTAMP is produced from DCAM.');
             elseif val == obj.DCAM.DCAMPROP_FRAMESTAMP_PRODUCER__KERNELDRIVER
                disp('FRAMESTAMP is produced from kernel driver.');
             elseif val ==  obj.DCAM.DCAMPROP_FRAMESTAMP_PRODUCER__CAPTUREDEVICE
                disp('FRAMESTAMP is produced from Frame Grabber.');
             elseif val ==  obj.DCAM.DCAMPROP_FRAMESTAMP_PRODUCER__IMAGINGDEVICE
                disp('FRAMESTAMP is produced from Camera.');
             else 
                 disp('error');         
             end
        end
        function [err, expTime] = GetExposureTime(obj)
            if obj.hdcam == 0
                err = 0;
                return;
            end
            [err, obj.expTime] = obj.DCAM.dcamprop_getvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_EXPOSURETIME , obj.expTime);
            if err < 0
                 obj.dcamcon_show_dcamerr( obj.DCAM, obj.hdcam, err, 'dcamprop_getvalue()' );
                return;
            end               
            expTime = obj.expTime; 
            if err >= 0
                fprintf('Exposure Time %d sec \n', expTime);
                
            end
        end
        function err = SetExposureTime(obj, expTime)
            obj.expTime = expTime;
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_EXPOSURETIME  ,obj.expTime);
            if err <= 0
                obj.dcamcon_show_dcamerr( obj.DCAM, obj.hdcam, err, 'dcamprop_setvalue' );
            end
            err = obj.GetExposureTime();
            
            
        end  
        function err = SetOutputTrigger(obj)
            
            %%%%% improve error handling
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_OUTPUTTRIGGER_KIND, obj.DCAM.DCAMPROP_OUTPUTTRIGGER_KIND__PROGRAMABLE);          
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_OUTPUTTRIGGER_DELAY, 0.0);
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_OUTPUTTRIGGER_PERIOD, 0.000001);
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_OUTPUTTRIGGER_SOURCE, obj.DCAM.DCAMPROP_OUTPUTTRIGGER_SOURCE__VSYNC);  
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_OUTPUTTRIGGER_POLARITY, obj.DCAM.DCAMPROP_OUTPUTTRIGGER_POLARITY__POSITIVE);  
             
            

        end
        function err = SetSoftwareTrigger(obj, delaySec)
            %%%%% improve error handling
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERSOURCE, obj.DCAM.DCAMPROP_TRIGGERSOURCE__SOFTWARE);          
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERDELAY, delaySec);          
        end
        function err = SetHardwareTrigger(obj, delaySec)
            %%%%% improve error handling
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERSOURCE, obj.DCAM.DCAMPROP_TRIGGERSOURCE__EXTERNAL);          
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERACTIVE, obj.DCAM.DCAMPROP_TRIGGERACTIVE__EDGE); 
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGER_CONNECTOR, obj.DCAM.DCAMPROP_TRIGGER_CONNECTOR__BNC);          
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGER_MODE, obj.DCAM.DCAMPROP_TRIGGER_MODE__NORMAL);          
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERPOLARITY, obj.DCAM.DCAMPROP_TRIGGERPOLARITY__POSITIVE); %%%%%CHECK         
            err = obj.DCAM.dcamprop_setvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERDELAY, delaySec);          
        end
        function [err, frameRate] = GetFrameRate(obj)
             frameRate = 0.0;
            [err, frameRate] = obj.DCAM.dcamprop_getvalue(obj.hdcam, obj.DCAM.DCAM_IDPROP_INTERNALFRAMERATE, frameRate); 
             if err <= 0
                obj.dcamcon_show_dcamerr( obj.DCAM, obj.hdcam, err, 'dcamprop_getvalue' );
            end        
            
        end      
        function Shutdown(obj)
            if obj.hwait, obj.DCAM.dcamwait_close( obj.hwait );end
            if obj.hdcam, obj.DCAM.dcamdev_close( obj.hdcam );end
            obj.DCAM.dcamapi_uninit();
            obj.DCAM.delete();
            obj.DCAM = 0;
        end
     
        function [err, im] = CaptureImageRunning(obj, number_of_buffer, ox, oy, cx, cy)
            im = [];
        	if obj.hdcam == 0  || obj.hwait == 0
                fprintf('hdcam or hwait not allocated\n');
                return;
            end
            % allocate buffer
            
            err = obj.DCAM.dcambuf_alloc( obj.hdcam, number_of_buffer );
            
            if( err < 0 )		
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcambuf_alloc()" );
                return;
            else
			% start capture
            mode = obj.DCAM.DCAMCAP_START_SEQUENCE; %continually captures images when buffer is filled it is recycled
			
            
            err = obj.DCAM.dcamcap_start( obj.hdcam, mode );
            if  err < 0
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcamcap_start()" );
            else
                %the capture has started and we need to wait until the
                %image data is ready to be accessed by the host software
                %so it will stop the moment it is told that data is
                %available
				%fprintf( "\nStart Capture\n" );
                timeout = 1000;
                waitStart = C_DCAMWAIT_START_(0, obj.DCAM.DCAMCAP_START_SEQUENCE, timeout); % NB using DCAMCAP_START_SNAP  creates an error
                [err, waitStart] = obj.DCAM.dcamwait_start(obj.hwait, waitStart);
                clear waitStart;
                % wait image
				if err < 0
					obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcamwait_start()" );
                else
                    %stop capture
                    obj.DCAM.dcamcap_stop( obj.hdcam );
                    
                    %fprintf( "Stop Capture\n" );
                    %access image
                    %fprintf( "Access Image\n" );

                    if nargin ~=6 
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod );
                    else
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod, ox, oy, cx, cy ); 
                    end
                end
            end
            % release buffer
            ikind = obj.DCAM.DCAM_DEFAULT_ARG;
            obj.DCAM.dcambuf_release( obj.hdcam, ikind );
        end
    
            
        end  
        function [err, im] = CaptureImage(obj, number_of_buffer, ox, oy, cx, cy)
            % this is a self contained version using software trigger and
            % firetrigger
            % check that no objects are made by the functions else they
            % will lead to dereferenced pointers
            im = [];
        	if obj.hdcam == 0  || obj.hwait == 0
                fprintf('hdcam or hwait not allocated\n');
                return;
            end
            obj.DCAM.dcamprop_setvalue( obj.hdcam, obj.DCAM.DCAM_IDPROP_TRIGGERSOURCE, obj.DCAM.DCAMPROP_TRIGGERSOURCE__SOFTWARE);
            % allocate buffer          
            err = obj.DCAM.dcambuf_alloc( obj.hdcam, number_of_buffer );
            
            if( err < 0 )		
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcambuf_alloc()" );
                return;
            else
			% start capture
            mode = obj.DCAM.DCAMCAP_START_SNAP; %single capture        
            err = obj.DCAM.dcamcap_start( obj.hdcam, mode );
            if  err < 0
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcamcap_start()" );
            else
                %the capture has started and we need to wait until the
                %image data is ready to be accessed by the host software
                %so it will stop the moment it is told that data is
                %available
				%fprintf( "\nStart Capture\n" );
                timeout = 2000;
                waitStart = C_DCAMWAIT_START_(0, obj.DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout); % NB using DCAMCAP_START_SNAP  creates an error
                
                err = obj.DCAM.dcamcap_firetrigger(obj.hdcam, 0); %fire the trigger
                % wait for the frame to be ready
                %sample shows getting the waitStart after firing the
                %trigger
                [err, waitStart] = obj.DCAM.dcamwait_start(obj.hwait, waitStart);
                clear waitStart;
                %stop capture
                obj.DCAM.dcamcap_stop( obj.hdcam );
                    
                %fprintf( "Stop Capture\n" );
                %access image
                %fprintf( "Access Image\n" );
                % the rest should be the same
                if nargin ~=6 
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod );
                    else
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod, ox, oy, cx, cy ); 
                    end
                end
            end
            % release buffer
            ikind = obj.DCAM.DCAM_DEFAULT_ARG;
            obj.DCAM.dcambuf_release( obj.hdcam, ikind );
        end
        function [err, im] = CaptureImageHardwareTrigger(obj, number_of_buffer, ox, oy, cx, cy)
            %must select the right type of trigger before use %%%%%
            % check that no objects are made by the functions else they
            % will lead to dereferenced pointers

            im = [];
        	if obj.hdcam == 0  || obj.hwait == 0
                fprintf('hdcam or hwait not allocated\n');
                return;
            end
            % allocate buffer          
            err = obj.DCAM.dcambuf_alloc( obj.hdcam, number_of_buffer );
            
            if( err < 0 )		
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcambuf_alloc()" );
                return;
            else
			% start capture
            mode = obj.DCAM.DCAMCAP_START_SNAP; %single capture        
            err = obj.DCAM.dcamcap_start( obj.hdcam, mode );
            if  err < 0
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcamcap_start()" );
            else
                %the capture has started and we need to wait until the
                %image data is ready to be accessed by the host software
                %so it will stop the moment it is told that data is
                %available
				%fprintf( "\nStart Capture\n" );
                timeout = 1000;
                waitStart = C_DCAMWAIT_START_(0, obj.DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout); % NB using DCAMCAP_START_SNAP  creates an error
                
                %previously the software trigger would fire here
                %now we put the camera into a wait mode.
                %the camera will continue once the hardware trigger has
                %been received
                obj.SetHardwareTrigger(0);
                tic;
                [err, waitStart] = obj.DCAM.dcamwait_start(obj.hwait, waitStart);
                obj.DCAM.dcamcap_stop( obj.hdcam );
                toc
                obj.SetSoftwareTrigger(0);
                clear waitStart;
                %stop capture               
                   
                %fprintf( "Stop Capture\n" );
                %access image
                %fprintf( "Access Image\n" );
                % the rest should be the same
                
                if nargin ~=6 
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod );
                else
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod, ox, oy, cx, cy ); 
                end
                toc
            end
                
            end
            % release buffer
            ikind = obj.DCAM.DCAM_DEFAULT_ARG;
            obj.DCAM.dcambuf_release( obj.hdcam, ikind );
        end
        function [err, im] = CaptureImageSoftwareTrigger(obj, number_of_buffer, ox, oy, cx, cy)
            % must select the right type of trigger before use
            % check that no objects are made by the functions else they
            % will lead to dereferenced pointers
            im = [];
        	if obj.hdcam == 0  || obj.hwait == 0
                fprintf('hdcam or hwait not allocated\n');
                return;
            end
            % allocate buffer          
            err = obj.DCAM.dcambuf_alloc( obj.hdcam, number_of_buffer );
            
            if( err < 0 )		
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcambuf_alloc()" );
                return;
            else
			% start capture
            mode = obj.DCAM.DCAMCAP_START_SNAP; %single capture        
            err = obj.DCAM.dcamcap_start( obj.hdcam, mode );
            if  err < 0
                obj.dcamcon_show_dcamerr( obj.hdcam, err, "dcamcap_start()" );
            else
                %the capture has started and we need to wait until the
                %image data is ready to be accessed by the host software
                %so it will stop the moment it is told that data is
                %available
				%fprintf( "\nStart Capture\n" );
                timeout = 1000;
                waitStart = C_DCAMWAIT_START_(0, obj.DCAM.DCAMWAIT_CAPEVENT_FRAMEREADY, timeout); % NB using DCAMCAP_START_SNAP  creates an error
                %fires the software trigger
                err = obj.DCAM.dcamcap_firetrigger(obj.hdcam, 0); %fire the trigger
                % wait for the frame to be ready
                %sample shows getting the waitStart after firing the
                %trigger
                [err, waitStart] = obj.DCAM.dcamwait_start(obj.hwait, waitStart);
                clear waitStart;
                %stop capture
                obj.DCAM.dcamcap_stop( obj.hdcam );
                    
                %fprintf( "Stop Capture\n" );
                %access image
                %fprintf( "Access Image\n" );
                % the rest should be the same
                if nargin ~=6 
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod );
                    else
                        [err, im] = obj.sample_access_image(obj.DCAM, obj.hdcam, obj.bCopyMethod, ox, oy, cx, cy ); 
                    end
                end
            end
            % release buffer
            ikind = obj.DCAM.DCAM_DEFAULT_ARG;
            obj.DCAM.dcambuf_release( obj.hdcam, ikind );
        end
        function err = DrawImage(obj, ox, oy, cx, cy)
            if nargin ~= 5
                [err, im] = obj.CaptureImage(1);
            else 
                [err, im] = obj.CaptureImage(1, ox, oy, cx, cy);
            end
            if err >= 0
               
                imagesc(im);  
                %colormap(gray) %it doesnt have to be grey
%                 colorbar
                drawnow();
            end
            
        end
        function DrawImages(obj)
            while true
                obj.DrawImage();
                
              
                
            end
            
        end
        function [err, hdcam, DCAM] = dcamcon_init_open(obj, bRelay)
            % dcamcon_init  loads DCAMAPI of RELAY DLL, creates a DCAM object, provides
            % a HDCAM handle
            % param bRelay:     uses the relay.dll to interecept commands to DCAM
 
                bDebug = false;
                err = -1;
                hdcam = 0;
                DCAM = DCAMSDK(bRelay, bDebug);
                disp('loaded DCAM');
                data = C_INT32_ARRAY_();
                guid = C_DCAM_GUID_();
                init = C_DCAMAPI_INIT_(0,0,data.SizeOf(), data, guid);
                [err, init] = DCAM.dcamapi_init(init);
                clear init guid data;
                if err < 0
                    return;
                end
                deviceToUse = 0;
                open = C_DCAMDEV_OPEN_(deviceToUse);
                [err, open] = DCAM.dcamdev_open(open);
                hdcam = open.GetHDCAM();
                clear open;
                if err < 0
                    return
                end
        end
        function err = dcamcon_show_dcamdev_info(obj, DCAM, hdcam )
            % dcamcon_show_dcamdev_info  lists out the key device info
            % param DCAM:  DCAM object
            % param hdcam:  hdcam handle object

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

        end
        function err = dcamcon_show_dcamerr(obj, DCAM, hdcam, idStr, fnSz )
            % dcamcon_show_dcamerr  display an error message for an error code
            % param DCAM:  DCAM SDK object
            % param hdcam:  hdcam handle
            % param idStr:  id of the error
            % param fnSz:   API that triggered the error
                param =  C_DCAMDEV_STRING_(idStr,[char(32*ones(1,300)) 0]);
                [err, param] = DCAM.dcamdev_getstring( hdcam, param );
                disp(strcat('ERROR:', fnSz, ':' , param.text));
        end
        function [err, pixeltype, width, rowbytes, height] = get_image_information(obj, DCAM, hdcam)
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
        function [err, im] = sample_access_image_snap(obj, DCAM, hdcam, bCopyFrame, ox, oy, cx, cy )
            % brief	sample used to process image after capturing.
            % details	This function copies the target area that is 1% of full area on the center.
            % param DCAM:  DCAM SDK object
            % param	hdcam:	DCAM handle
            % param bCopyFrame  copy the pixels on the camera rather than locking 
            % param ox, oy, cx, cy  ROI

            err = 1;
            im = 0;
                transferinfo = C_DCAMCAP_TRANSFERINFO_();
                % get number of captured image
                [err, transferinfo] = DCAM.dcamcap_transferinfo( hdcam, transferinfo );
                if err < 0 
                    clear transferinfo;
                    return;
                end
                if transferinfo.nFrameCount < 1 	
                    fprintf( 'NO IMAGES TRANSFERRED\n' );
                    clear transferinfo;
                    return;
                end
                fprintf('Num of images transfered:%d\n', transferinfo.nFrameCount);
                % get image information
                [err, obj.pixelType, obj.imageWidth, obj.rowBytes, obj.imageHeight] = get_image_information( DCAM, hdcam);
                if obj.pixelType ~= DCAM.DCAM_PIXELTYPE_MONO16 	
                    fprintf( 'not implement\n' );
                    clear transferinfo;
                    return;
                end
                
                if nargin ~= 8
                    ox = 0;
                    oy = 0;
                    cx = obj.imageWidth;
                    cy = obj.imageHeight;
                end
                
                for iFrame = 0
                    % copy image
                    [err, im] = obj.copy_targetarea( DCAM, bCopyFrame, hdcam, iFrame, cx * 2, ox, oy, cx, cy );			
                end
                clear transferinfo;
                %%%%%%%ARHHHHH!!!!! im = im.';
        end
        function [err, im] = sample_access_images_snap(obj, DCAM, hdcam, ix_frame, bCopyFrame, ox, oy, cx, cy )
            % brief	sample used to process image after capturing.
            % details	This function copies the target area that is 1% of full area on the center.
            % param DCAM:  DCAM SDK object
            % param	hdcam:	DCAM handle
            % param bCopyFrame  copy the pixels on the camera rather than locking 
            % param ox, oy, cx, cy  ROI

            err = 1;
            im = 0;
                transferinfo = C_DCAMCAP_TRANSFERINFO_();
                % get number of captured image
                [err, transferinfo] = DCAM.dcamcap_transferinfo( hdcam, transferinfo );
                if err < 0 
                    clear transferinfo;
                    return;
                end
                if transferinfo.nFrameCount < 1 	
                    fprintf( 'NO IMAGES TRANSFERRED\n' );
                    clear transferinfo;
                    return;
                end
                fprintf('Num of images transfered:%d\n', transferinfo.nFrameCount);
                % get image information
                [err, obj.pixelType, obj.imageWidth, obj.rowBytes, obj.imageHeight] = get_image_information( DCAM, hdcam);
                if obj.pixelType ~= DCAM.DCAM_PIXELTYPE_MONO16 	
                    fprintf( 'not implement\n' );
                    clear transferinfo;
                    return;
                end
                
                if nargin ~= 8
                    ox = 0;
                    oy = 0;
                    cx = obj.imageWidth;
                    cy = obj.imageHeight;
                end
                
                for iFrame = (ix_frame - 1)
                    % copy image
                    [err, im] = obj.copy_targetarea( DCAM, bCopyFrame, hdcam, iFrame, cx * 2, ox, oy, cx, cy );			
                end
                clear transferinfo;
                 %%%%%%%ARHHHHH!!!!! im = im.';
        end
        function [err, im] = sample_access_image(obj, DCAM, hdcam, bCopyFrame, ox, oy, cx, cy )
            % brief	sample used to process image after capturing.
            % details	This function copies the target area that is 1% of full area on the center.
            % param DCAM:  DCAM SDK object
            % param	hdcam:	DCAM handle
            % param bCopyFrame  copy the pixels on the camera rather than locking 
            % param ox, oy, cx, cy  ROI

                transferinfo = C_DCAMCAP_TRANSFERINFO_();
                % get number of captured image
                [err, transferinfo] = DCAM.dcamcap_transferinfo( hdcam, transferinfo );
                if err < 0 
                    clear transferinfo;
                    return;
                end
                if transferinfo.nFrameCount < 1 	
                    fprintf( 'not captured an image\n' );
                    clear transferinfo;
                    err = -1;
                    im = 0;
                    return;
                end
                % get image information
                [err, obj.pixelType, obj.imageWidth, obj.rowBytes, obj.imageHeight] = get_image_information( DCAM, hdcam);
                if obj.pixelType ~= DCAM.DCAM_PIXELTYPE_MONO16 	
                    fprintf( 'not implement\n' );
                    clear transferinfo;
                    return;
                end
                
                if nargin ~= 8
                    ox = 0;
                    oy = 0;
                    cx = obj.imageWidth;
                    cy = obj.imageHeight;
                end
                
                for iFrame = 0: (transferinfo.nFrameCount - 1)
                    % copy image
                    [err, im] = obj.copy_targetarea( DCAM, bCopyFrame, hdcam, iFrame, cx * 2, ox, oy, cx, cy );			
                end
                clear transferinfo;
                im = im.';
                %%%%%%%ARHHHHH!!!!!im = im.';
        end
        function [bRet, buf] =  copy_targetarea(obj, DCAM, bCopy,  hdcam, iFrame,  rowbytes, ox, oy, cx, cy ) 
            % copy_targetarea  Copies a rect region on the frame buffer 

                bufframe = C_DCAMBUF_FRAME_(iFrame);
                % prepare buffer for ROI


                if bCopy == true
                % the memory allocated by MATLAB will be passed to DCAM to
                % be copied, the copying takes place inside the camera
                            bufframe.buf		= uint16(zeros(cx,cy));%%%%%%%changes swapped cx cy WORKED 14/4/19
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
    end
  
    
end