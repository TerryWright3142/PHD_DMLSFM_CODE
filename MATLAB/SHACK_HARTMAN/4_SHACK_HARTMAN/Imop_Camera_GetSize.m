function [err_message, size, bit_depth] = Imop_Camera_GetSize(Camera)

% IMOP_CAMERA_GETSIZE Get Camera dimensions and depth.
% 
%    Camera       Camera object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    size         Camera size (width, height).
%                 
%    bit_depth    Camera bits depth.
%                 
% 

if nargin ~= 1
	error('The "Imop_Camera_GetSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = [];
bit_depth = 0;

[err_nb, err_message, size, bit_depth] = calllib('WaveKitRuntime', 'Imop_Camera_GetSize', err_message, Camera, size, bit_depth);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
