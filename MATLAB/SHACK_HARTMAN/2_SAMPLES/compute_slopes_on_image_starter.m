% OK 17/5/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
image_file_path = 'synchronous_acquisition_image_1000.himg';
message = char(ones(256,1,'int8'));
[message,image] = Imop_Image_NewFromFile(image_file_path);
start_supupil = struct('X',0,'Y',0);
start_supupil.X = 16;
start_supupil.Y = 16;
%I had to reduce the exposure to 30ms before it could calculate the slopes,
%this must be because there was saturation 
[message,hasoslopes] = Imop_HasoSlopes_NewFromImage(image,config_file_path,start_supupil);
[message, serial_number, dimensions, steps] = Imop_HasoSlopes_GetInfo(hasoslopes);
bufferX = zeros(int32([dimensions.X dimensions.Y]));
[message, bufferX] = Imop_HasoSlopes_GetSlopesX(hasoslopes, bufferX);
bufferX(isnan(bufferX)) = 0;
imagesc(bufferX);
%check the next function with the sdk
[message] = Imop_HasoSlopes_SaveToFile(hasoslopes,'data_phase_computation_example.has','compute slopes example','compute_slopes_example_session');
fprintf('Haso slopes computation data saved to file %s.\n', 'data_phase_computation_example.has');

[message] = Imop_Image_Delete(image);
[message] = Imop_HasoSlopes_Delete(hasoslopes);
Imop_Runtime_Unload_x64();

