function [err_message, Image] = Imop_Image_SubtractionABC(ImageA, ImageB, Image)

% IMOP_IMAGE_SUBTRACTIONABC Subtraction : Image = ImageA - ImageB.
%    Images must have the same size, channels count and bits depth.
% 
%    ImageA       Image object adress.
%                 
%    ImageB       Image object adress.
%                 
%    Image        Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 3
	error('The "Imop_Image_SubtractionABC" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Image_SubtractionABC', err_message, ImageA, ImageB, Image);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
