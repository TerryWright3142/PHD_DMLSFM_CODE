function err_message = Imop_Camera_SetBackground(Camera, bg_Image)

% IMOP_CAMERA_SETBACKGROUND Set Camera background image.
%    Image with substracted background can be retrieved using
%    the Imop_Camera_GetLastImage function with remove_background_c = 1
% 
%    Camera       Camera object adress.
%                 
%    bg_Image     Background image.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Camera_SetBackground" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_SetBackground', err_message, Camera, bg_Image);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
