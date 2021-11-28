function [err_message, Image] = Imop_Image_SetData(Image, buffer)

% IMOP_IMAGE_SETDATA Set pixels buffer as an unsigned int array.
% Maximum value in buffer is assessed against the bit depth of the image.
%    Please make sure buffer and image dimensions are coherent.
%    buffer       Pixel buffer.
%                 
%    Image        Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_SetData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Image_SetData', err_message, Image, buffer);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
