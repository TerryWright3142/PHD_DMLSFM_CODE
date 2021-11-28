function [err_message, buffer] = Imop_Image_GetDataU8(Image, buffer)

% IMOP_IMAGE_GETDATAU8 Get pixels buffer from 8-bit unsigned Image.
% Provided for refined memory handling.
%    Image        Image object adress.
%                 
%    buffer       Pixel buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_GetDataU8" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Image_GetDataU8', err_message, Image, buffer);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
