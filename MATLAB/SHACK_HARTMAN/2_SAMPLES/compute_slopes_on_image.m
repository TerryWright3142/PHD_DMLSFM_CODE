%OK 17/5/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
image_file_path = 'synchronous_acquisition_image_1000.himg';
message = char(ones(256,1,'int8'));
%% create the needed objects : image, HasoEngine to compute the slopes and hasoslopes.
[message,image] = Imop_Image_NewFromFile(image_file_path);
[message,hasoslopes] = Imop_HasoSlopes_NewFromConfigFile(config_file_path);
[message,slopesengine] = Imop_HasoEngine_NewFromConfigFile(config_file_path); 
%% by default the start subpupil is set by the one in the configuration file.
% it is close to the center of the sensor - so maybe we should change it to the actual centre %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this example it is arbitrary set to (20,20).
start_supupil = struct('X',0,'Y',0);
start_supupil.X = 16;
start_supupil.Y = 16;
%%Apply preferences.
denoising_strength = 1.0;
[message] = Imop_HasoEngine_SetPreferences(slopesengine,start_supupil,denoising_strength);
%% Compute slopes and save them.
learn_from_trimmer = 0;
trimmer_quality = 0.0;
[message,hasoslopes,trimmer_quality] = Imop_HasoEngine_ComputeSlopes(slopesengine,hasoslopes,image,learn_from_trimmer);
[message] = Imop_HasoSlopes_SaveToFile(hasoslopes,'data_phase_computation_example1.has','compute slopes example','compute_slopes_example_session');
fprintf('Haso slopes computation data saved to file %s.\n', 'data_phase_computation_example1.has');
%% Delete all the objects.
[message] = Imop_Image_Delete(image);
[message] = Imop_HasoEngine_Delete(slopesengine);
[message] = Imop_HasoSlopes_Delete(hasoslopes);

Imop_Runtime_Unload_x64();
clear; 
