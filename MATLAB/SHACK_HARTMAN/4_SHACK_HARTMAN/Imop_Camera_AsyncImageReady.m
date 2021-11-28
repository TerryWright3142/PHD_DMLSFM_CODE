function [err_message, is_ready] = Imop_Camera_AsyncImageReady(Camera)

% IMOP_CAMERA_ASYNCIMAGEREADY Indicates if a new image is available.
% 
%    Camera       Camera object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    is_ready     image availability in asynchronous image synchronization mode.
%                 
% 

if nargin ~= 1
	error('The "Imop_Camera_AsyncImageReady" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
is_ready = 0;

[err_nb, err_message, is_ready] = calllib('WaveKitRuntime', 'Imop_Camera_AsyncImageReady', err_message, Camera, is_ready);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
