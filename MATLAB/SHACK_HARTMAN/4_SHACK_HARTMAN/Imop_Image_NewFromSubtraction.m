function [err_message, Image] = Imop_Image_NewFromSubtraction(ImageA, ImageB)

% IMOP_IMAGE_NEWFROMSUBTRACTION Image constructor from a subtraction of two images : (new) image = imageA - imageB
% 
%    ImageA       Image object adress.
%                 
%    ImageB       Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Image        Pointer to Image object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_NewFromSubtraction" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Image = 0;

[err_nb, err_message, Image] = calllib('WaveKitRuntime', 'Imop_Image_NewFromSubtraction', err_message, ImageA, ImageB, Image);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
