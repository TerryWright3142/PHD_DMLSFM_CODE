function Imop_Image_IsHasoImage()

% IMOP_IMAGE_ISHASOIMAGE Check if Image has been captured with a Haso sensor.
% 
% 

if nargin ~= 0
	error('The "Imop_Image_IsHasoImage" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Image_IsHasoImage');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
