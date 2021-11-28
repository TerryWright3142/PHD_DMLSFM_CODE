function [err_message, bg_Image] = Imop_Camera_GetBackground(Camera, bg_Image)

% IMOP_CAMERA_GETBACKGROUND Get Camera background image.
% 
%    Camera       Camera object adress.
%                 
%    bg_Image     Background image.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Camera_GetBackground" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_GetBackground', err_message, Camera, bg_Image);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
