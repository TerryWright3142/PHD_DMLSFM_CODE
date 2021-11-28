function [err_message, Camera] = Imop_Camera_NewFromConfigFile(config_file_path)

% IMOP_CAMERA_NEWFROMCONFIGFILE Camera constructor
% 
%    config_file_path  Absolute path to Haso or Camera configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    Camera            Pointer to Camera object adress.
%                      
% 

if nargin ~= 1
	error('The "Imop_Camera_NewFromConfigFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Camera = 0;

[err_nb, err_message, Camera, config_file_path] = calllib('WaveKitRuntime', 'Imop_Camera_NewFromConfigFile', err_message, Camera, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
