classdef Shack_Hartman < handle
    %OK 18/5/18
    %3/6/18 removed the flip and rotate so that gives the same result as
    %the influence functions of the dm
    properties 
        E_COMPUTEPHASESET_MODAL_LEGENDRE = 1;
        E_COMPUTEPHASESET_MODAL_ZERNIKE = 2;
        E_COMPUTEPHASESET_ZONAL = 3;
        E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE = 4;
        E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE = 5;
        E_ACTUATOR_CONDITION_VALID = 0;
        E_ACTUATOR_CONDITION_FIXED = 1;
        E_ACTUATOR_CONDITION_INVALID = 2;
        E_CAMERA_ACQ_LAST = 0;
        E_CAMERA_ACQ_NEW = 1;
        E_CAMERA_SYNCHRONOUS = 0;
        E_CAMERA_ASYNCHRONOUS = 1;
        E_MODALCOEF_LEGENDRE = 0;
        E_MODALCOEF_ZERNIKE = 1;
        E_ZERNIKE_NORM_STD = 0;
        E_ZERNIKE_NORM_RMS = 1;
        E_PUPIL_FIXED_RADIUS = 0;
        E_PUPIL_FIXED_CENTER = 1;
        E_PUPIL_AUTOMATIC = 2;
        E_PUPIL_INSCRIBED = 0;
        E_PUPIL_CIRCUMSCRIBED = 1;
        E_SPOTDETECT_STANDARD = 0;
        E_SPOTDETECT_FAST = 1;
        E_TYPE_BOOL = 0;
        E_TYPE_INT = 1;
        E_TYPE_REAL = 2;
        E_TYPE_STRING = 3;
        E_TYPE_SLOPES = 4;
        E_TYPE_IMAGE = 5;
        E_STITCH_POSTPROCESS_NONE = 0;
        E_STITCH_POSTPROCESS_REF_CURV_ERROR = 1;
        E_STITCH_POSTPROCESS_THERMAL_DRIFT = 2;
        %
        %
        config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
        %
        hCamera = 0;
        hImage = 0;
        hHasoSlopes = 0;
        hPhase = 0;
        hPupil = 0;
        hasoslopes_ref = 0;
        %
        bBackground = false;
        start_subpupil = struct('X',18,'Y',16); % Imagine samples was (18,16)
        exposure_duration = 30;
        timeout = 4000;
        message = char(ones(256,1,'int8'));
        %
        size;
        bit_depth;
        %
        bDefocus = 1;
        bTiltx = 0; 
        bTilty = 0;
        szReferenceFlat = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\SHACK_HARTMAN\4_SHACK_HARTMAN\30_1_20.has';
    end  
    methods 
        function obj = Shack_Hartman()

        end
        function Init(obj)
            Imop_Runtime_Load_x64();
            [obj.message,obj.hCamera] = Imop_Camera_NewFromConfigFile(obj.config_file_path); %appears to need an absolute path, it wont work if the ImagineOptic application is running
            [obj.message] = Imop_Camera_SetParameterInt(obj.hCamera,'exposure_duration_us',obj.exposure_duration);
            [obj.message,obj.exposure_duration] = Imop_Camera_GetParameterInt(obj.hCamera,'exposure_duration_us');
            [obj.message] = Imop_Camera_SetTimeOut(obj.hCamera,obj.timeout);
            [obj.message,obj.timeout] = Imop_Camera_GetTimeOut(obj.hCamera);
            [obj.message] = Imop_Camera_Start(obj.hCamera,obj.E_CAMERA_ACQ_NEW,obj.E_CAMERA_SYNCHRONOUS);
            [obj.message,obj.size,obj.bit_depth] = Imop_Camera_GetSize(obj.hCamera);
            [obj.message, obj.hImage] = Imop_Image_New(obj.size,32);
            obj.LoadReferenceFromFile(obj.szReferenceFlat);   
        end
        function SetupReferenceFlat(obj)
            %put the lam/10 flat in the same position as the DM
            fprintf('***\nTaking a reference image.\n The displacement of the spots of future images will have the displacement \n of the spots of this image subtracted. It zeros the SH \n***\n');
            obj.DoNotRemoveTiltDefocus(1,1,1);
            obj.ReleaseReference();
            obj.SetReference(obj.szReferenceFlat);
            obj.LoadReferenceFromFile(obj.szReferenceFlat);  
            obj.DoNotRemoveTiltDefocus(0,0,1);
      
        end
        function Shutdown(obj)
            %does this need an order
            obj.ReleaseReference();
            Imop_Camera_Delete(obj.hCamera);
            Imop_Image_Delete(obj.hImage);
            Imop_Runtime_Unload_x64();
        end
        function DoNotRemoveTiltDefocus(obj, bTiltx, bTilty, bDefocus)
            %1 means do not remove from the phase
            obj.bTiltx = bTiltx;
            obj.bTilty = bTilty;
            obj.bDefocus = bDefocus;
        end
        function phase = CaptureImage(obj, szFile)
            %captures an image and possibly saves it to a file szFile
            [obj.message,obj.hImage] = Imop_Camera_GetImage(obj.hCamera,obj.hImage);            
            if nargin > 1
                %save the image file - everything can be recreated from
                %this, save as an .himg
                [obj.message] = Imop_Image_Save(obj.hImage,'synchronous acquisition', szFile);
                
            end
             [obj.message,obj.hHasoSlopes] = Imop_HasoSlopes_NewFromImage(obj.hImage,obj.config_file_path,obj.start_subpupil);
             if obj.hasoslopes_ref ~= 0
                 %subtract the slopes of a reference

                 [obj.message, obj.hHasoSlopes] = Imop_SlopesPostProcessor_ApplySubstractor(obj.hHasoSlopes, obj.hasoslopes_ref);              
      
             end     
             %integrate to find the slopes
             [obj.message,obj.hPhase] = Imop_Phase_NewFromSlopes(obj.hHasoSlopes,obj.E_COMPUTEPHASESET_ZONAL,[obj.bTiltx, obj.bTilty, obj.bDefocus  1 1]);
             [obj.message,obj.hPupil] = Imop_Pupil_NewFromHasoSlopes(obj.hHasoSlopes);
             [obj.message, dimensions, ~] = Imop_Phase_GetDimensionsAndSteps(obj.hPhase);
            phase = zeros(int32([dimensions.X dimensions.Y]));
            [obj.message, phase, obj.hPupil] = Imop_Phase_GetData(obj.hPhase, phase, obj.hPupil);
            phase = flipud(phase);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            phase = fliplr(phase);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            Imop_HasoSlopes_Delete(obj.hHasoSlopes);
            Imop_Phase_Delete(obj.hPhase);
            Imop_Pupil_Delete(obj.hPupil);

        end 
        function Draws(obj)
            fprintf('ctrl c to end\n');
            while true
               obj.Draw();
               drawnow();    
            end
        end
        function Draw(obj)
            colormap hot;
            im = obj.CaptureImage();
            imagesc(im, [-0.5, 0.5]);
            title(num2str(std(im(~isnan(im)))));
            colorbar;
        end
        
        function DrawSlopes(obj, hHasoSlopes)
            %draw the X slopes and the Y slopes
            figure(1);
            [message, serial_number, dimensions, steps] = Imop_HasoSlopes_GetInfo(hHasoSlopes);
            bufferX = zeros(int32([dimensions.X dimensions.Y]));
            [message, bufferX] = Imop_HasoSlopes_GetSlopesX(hHasoSlopes, bufferX);
            imagesc(bufferX);
            title('X slopes');
            colorbar;
            drawnow;
            figure(2);
            bufferY = zeros(int32([dimensions.X dimensions.Y]));
            [message, bufferY] = Imop_HasoSlopes_GetSlopesY(hHasoSlopes, bufferY);
            imagesc(bufferY);
            title('Y slopes');
            colorbar;
            drawnow;      
        end
        function DisplaySlopes(obj, hHasoSlopes)
            %print the X slopes and the Y slopes out
            disp('X slopes');
            [message, serial_number, dimensions, steps] = Imop_HasoSlopes_GetInfo(hHasoSlopes);
            bufferX = zeros(int32([dimensions.X dimensions.Y]));
            [message, bufferX] = Imop_HasoSlopes_GetSlopesX(hHasoSlopes, bufferX);
            disp('Y slopes');
            disp(bufferX);
            bufferY = zeros(int32([dimensions.X dimensions.Y]));
            [message, bufferY] = Imop_HasoSlopes_GetSlopesY(hHasoSlopes, bufferY);
            
            
            
        end
        function SetReference(obj, szFile)
            %capture a reference set of slopes and save to file
            obj.ReleaseReference();
            [message,obj.hImage] = Imop_Camera_GetImage(obj.hCamera, obj.hImage); 
            [message,obj.hasoslopes_ref] = Imop_HasoSlopes_NewFromImage(obj.hImage,obj.config_file_path,obj.start_subpupil);
            if nargin > 1
               [message] = Imop_HasoSlopes_SaveToFile(obj.hasoslopes_ref,szFile,'compute slopes example','compute_slopes_example_session');
 
                
            end
            
        end
        function LoadReferenceFromFile(obj, szFile)
            %load a set of references from file
            obj.ReleaseReference();
            [message,obj.hasoslopes_ref] = Imop_HasoSlopes_NewFromHasFile(szFile);
            
        end
        function ReleaseReference(obj)
            %release the reference
            if obj.hasoslopes_ref ~= 0
                Imop_HasoSlopes_Delete(obj.hasoslopes_ref); 
                obj.hasoslopes_ref = 0;
                
            end
        end
    end
end


        


