function err_message = Imop_Camera_Start(Camera, acquisition_mode, synchronization_mode)

% IMOP_CAMERA_START Start acquisition
% 
%    Camera                Camera object adress.
%                          
%    acquisition_mode      Acquisition mode : can be 0 (last_image) or 1 (new_image).
%                          
%    synchronization_mode  Synchronisation mode : can be 0 (synchronous) or 1 (asynchronous).
%                          
%    err_message           Error message, empty if no error occured.
%                          
% 

if nargin ~= 3
	error('The "Imop_Camera_Start" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_Start', err_message, Camera, acquisition_mode, synchronization_mode);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
