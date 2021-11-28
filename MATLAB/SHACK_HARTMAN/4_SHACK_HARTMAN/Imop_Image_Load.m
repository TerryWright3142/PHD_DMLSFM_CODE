function err_message = Imop_Image_Load(Image, image_file_path)

% IMOP_IMAGE_LOAD Load Image from file.
% 
%    Image            Image object adress.
%                     
%    image_file_path  Absolute path to image file.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 2
	error('The "Imop_Image_Load" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, image_file_path] = calllib('WaveKitRuntime', 'Imop_Image_Load', err_message, Image, image_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
