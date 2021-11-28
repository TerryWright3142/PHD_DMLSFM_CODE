function [err_message, ImageA] = Imop_Image_Assignment(ImageA, ImageB)

% IMOP_IMAGE_ASSIGNMENT Deep copy : copy ImageB content to ImageA.
%    Images must have the same size, channels count and bits depth.
% 
%    ImageB       Pointer to source image object.
%                 
%    ImageA       Pointer to destination Image object.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Image_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Image_Assignment', err_message, ImageA, ImageB);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
