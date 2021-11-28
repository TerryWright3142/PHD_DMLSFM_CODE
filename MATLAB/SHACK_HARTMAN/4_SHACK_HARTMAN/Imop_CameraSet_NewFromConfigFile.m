function [err_message, camera_set] = Imop_CameraSet_NewFromConfigFile(config_file_path)

% IMOP_CAMERASET_NEWFROMCONFIGFILE CameraSet constructor
% 
%    config_file_path  Absolute path to Haso or Camera configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    camera_set        Pointer to CameraSet object adress.
%                      
% 

if nargin ~= 1
	error('The "Imop_CameraSet_NewFromConfigFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
camera_set = 0;

[err_nb, err_message, camera_set, config_file_path] = calllib('WaveKitRuntime', 'Imop_CameraSet_NewFromConfigFile', err_message, camera_set, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
