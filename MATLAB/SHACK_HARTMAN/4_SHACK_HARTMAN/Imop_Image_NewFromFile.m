function [err_message, Image] = Imop_Image_NewFromFile(image_file_path)

% IMOP_IMAGE_NEWFROMFILE Image constructor from file.
% 
%    image_file_path  Absolute path to image file.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    Image            Pointer to Image object adress.
%                     
% 

if nargin ~= 1
	error('The "Imop_Image_NewFromFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Image = 0;

[err_nb, err_message, Image, image_file_path] = calllib('WaveKitRuntime', 'Imop_Image_NewFromFile', err_message, Image, image_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
