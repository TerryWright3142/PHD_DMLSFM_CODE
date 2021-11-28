function [err_message, is_running, acquisition_mode, synchronization_mode] = Imop_Camera_GetState(camera)

% IMOP_CAMERA_GETSTATE Get camera state : running or not, acquisition mode, synchronisation mode.
% 
%    camera                Camera object adress.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    is_running            image availability in asynchronous image synchronization mode.
%                          
%    acquisition_mode      image acquisition mode.
%                          
%    synchronization_mode  image synchronization mode.
%                          
% 

if nargin ~= 1
	error('The "Imop_Camera_GetState" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
is_running = 0;
acquisition_mode = 0;
synchronization_mode = 0;

[err_nb, err_message, is_running, acquisition_mode, synchronization_mode] = calllib('WaveKitRuntime', 'Imop_Camera_GetState', err_message, camera, is_running, acquisition_mode, synchronization_mode);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
