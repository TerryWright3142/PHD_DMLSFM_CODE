function [err_message, ImageA] = Imop_Image_SubtractionAB(ImageA, ImageB)

% IMOP_IMAGE_SUBTRACTIONAB Inplace subtraction : ImageA = ImageA - ImageB.
%    Images must have the same size, channels count and bits depth.
% 
%    ImageB       Image object adress.
%                 
%    ImageA       Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_SubtractionAB" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Image_SubtractionAB', err_message, ImageA, ImageB);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
