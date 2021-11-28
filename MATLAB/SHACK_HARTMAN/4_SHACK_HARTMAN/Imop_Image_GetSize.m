function [err_message, size, bit_depth] = Imop_Image_GetSize(Image)

% IMOP_IMAGE_GETSIZE Get Image size.
% 
%    Image        Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    size         Image size (width, height).
%                 
%    bit_depth    Image bits depth.
%                 
% 

if nargin ~= 1
	error('The "Imop_Image_GetSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = [];
bit_depth = 0;

[err_nb, err_message, size, bit_depth] = calllib('WaveKitRuntime', 'Imop_Image_GetSize', err_message, Image, size, bit_depth);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
