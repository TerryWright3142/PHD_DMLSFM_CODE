% working 17/5/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
message = char(ones(256,1,'int8'));
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';

[message,h_cam] = Imop_Camera_NewFromConfigFile(config_file_path); %appears to need an absolute path, it wont work if the ImagineOptic application is running

exposure_duration = 30;
[message] = Imop_Camera_SetParameterInt(h_cam,'exposure_duration_us',exposure_duration);
fprintf('Exposure time requested : %u\n', exposure_duration);
[message,exposure_duration] = Imop_Camera_GetParameterInt(h_cam,'exposure_duration_us');
fprintf('Exposure time applied   : %d\n', exposure_duration);


timeout = 4000;
[message] = Imop_Camera_SetTimeOut(h_cam,timeout);
fprintf('Time out requested      : %u\n', timeout);
[message,timeout] = Imop_Camera_GetTimeOut(h_cam);
fprintf('Time out applied        : %u\n', timeout);

[message] = Imop_Camera_Start(h_cam,E_CAMERA_ACQ_NEW,E_CAMERA_SYNCHRONOUS);

size = struct('X',0,'Y',0);
[message,size,bit_depth] = Imop_Camera_GetSize(h_cam);
fprintf('Image size              : %u x %u (%u bits)\n', size.X, size.Y, bit_depth);
[message,h_image] = Imop_Image_New(size,32);

[message,h_image] = Imop_Camera_GetImage(h_cam,h_image);
[message] = Imop_Image_Save(h_image,'synchronous acquisition test','synchronous_acquisition_image_1000.himg');
fprintf('Image saved to file %s.\n', 'synchronous_acquisition_image_1000.himg');

[message] = Imop_Image_Delete(h_image);
[message] = Imop_Camera_Stop(h_cam);
[message] = Imop_Camera_Delete(h_cam);

Imop_Runtime_Unload_x64();
clear; 
