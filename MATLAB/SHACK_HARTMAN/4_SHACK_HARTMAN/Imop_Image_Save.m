function err_message = Imop_Image_Save(Image, comments, image_file_path)

% IMOP_IMAGE_SAVE Save Image to file.
% 
%    Image            Image object adress.
%                     
%    comments         Comments to add.
%                     
%    image_file_path  Absolute path to image file.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_Image_Save" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, comments, image_file_path] = calllib('WaveKitRuntime', 'Imop_Image_Save', err_message, Image, comments, image_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
