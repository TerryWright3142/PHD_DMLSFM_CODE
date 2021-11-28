function err_message = Imop_Camera_SetTimeOut(Camera, TimeOut)

% IMOP_CAMERA_SETTIMEOUT Set Camera time out value.
% 
%    Camera       Camera object adress.
%                 
%    TimeOut      Time out value (ms).
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Camera_SetTimeOut" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_SetTimeOut', err_message, Camera, TimeOut);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
