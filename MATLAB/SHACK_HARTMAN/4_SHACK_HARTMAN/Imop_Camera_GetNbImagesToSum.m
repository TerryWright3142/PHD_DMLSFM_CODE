function [err_message, images_count] = Imop_Camera_GetNbImagesToSum(Camera)

% IMOP_CAMERA_GETNBIMAGESTOSUM Get number of images to sum.
% Summing images makes the measured wavefront less sensitive to noise  (temporal average effect).
%    Camera        Camera object adress.
%                  
%    err_message   Error message, empty if no error occured.
%                  
%    images_count  Images count.
%                  
% 

if nargin ~= 1
	error('The "Imop_Camera_GetNbImagesToSum" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
images_count = 0;

[err_nb, err_message, images_count] = calllib('WaveKitRuntime', 'Imop_Camera_GetNbImagesToSum', err_message, Camera, images_count);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
