function [err_message, buffer] = Imop_Image_GetData(Image, buffer)

% IMOP_IMAGE_GETDATA Get pixels buffer as an unsigned int array.
% This function wraps the specialized ones (GetDataU8 / GetDataU16 / GetDataU32).
%    to provide a simplified access to pixels values (no bit depth check needed).
%    Image        Image object adress.
%                 
%    buffer       Pixel buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_GetData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Image_GetData', err_message, Image, buffer);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
