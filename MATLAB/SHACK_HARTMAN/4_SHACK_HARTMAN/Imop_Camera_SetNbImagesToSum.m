function err_message = Imop_Camera_SetNbImagesToSum(Camera, images_count)

% IMOP_CAMERA_SETNBIMAGESTOSUM Set number of images to sum
% Summing images makes the measured wavefront less sensitive to noise (temporal average effect).
%    Camera        Camera object adress.
%                  
%    images_count  Images count.
%                  
%    err_message   Error message, empty if no error occured.
%                  
% 

if nargin ~= 2
	error('The "Imop_Camera_SetNbImagesToSum" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_SetNbImagesToSum', err_message, Camera, images_count);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
