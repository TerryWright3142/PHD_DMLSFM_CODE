function [err_message, Image] = Imop_Image_New(size, bit_depth)

% IMOP_IMAGE_NEW Single channel Image constructor from dimensions and bit depth.
% 
%    size         2D image size.
%                 
%    bit_depth    Image bits depth.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Image        Pointer to Image object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_New" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Image = 0;

[err_nb, err_message, Image, size] = calllib('WaveKitRuntime', 'Imop_Image_New', err_message, Image, size, bit_depth);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
