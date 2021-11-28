function [err_message, Image] = Imop_Image_NewFromConfig(config_file_path)

% IMOP_IMAGE_NEWFROMCONFIG Not available
% 
%    config_file_path  Absolute path to image file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    Image             Pointer to Image object adress.
%                      
% 

if nargin ~= 1
	error('The "Imop_Image_NewFromConfig" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Image = 0;

[err_nb, err_message, Image, config_file_path] = calllib('WaveKitRuntime', 'Imop_Image_NewFromConfig', err_message, Image, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
