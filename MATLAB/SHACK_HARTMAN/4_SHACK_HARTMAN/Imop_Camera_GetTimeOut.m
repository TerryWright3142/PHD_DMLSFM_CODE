function [err_message, TimeOut] = Imop_Camera_GetTimeOut(Camera)

% IMOP_CAMERA_GETTIMEOUT Get Camera time out value.
% 
%    Camera       Camera object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    TimeOut      Time out value (ms).
%                 
% 

if nargin ~= 1
	error('The "Imop_Camera_GetTimeOut" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
TimeOut = 0;

[err_nb, err_message, TimeOut] = calllib('WaveKitRuntime', 'Imop_Camera_GetTimeOut', err_message, Camera, TimeOut);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
