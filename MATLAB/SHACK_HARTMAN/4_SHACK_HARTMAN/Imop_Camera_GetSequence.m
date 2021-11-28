function [err_message, image_array] = Imop_Camera_GetSequence(Camera, image_array_size, image_array)

% IMOP_CAMERA_GETSEQUENCE Ask camera for array_size captures and retrieve images array (Synchronous mode - Blocking).
% 
%    Camera            Camera object adress.
%                      
%    image_array_size  Captured sequence length (number of images).
%                      
%    image_array       Captured sequence as image array.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 3
	error('The "Imop_Camera_GetSequence" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, image_array] = calllib('WaveKitRuntime', 'Imop_Camera_GetSequence', err_message, Camera, image_array_size, image_array);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
