function [err_message, parameter_name] = Imop_CameraSet_GetParameterName(camera_set, index)

% IMOP_CAMERASET_GETPARAMETERNAME Camera parameter name getter given its position in the parameters list.
% 
%    camera_set      CameraSet object adress.
%                    
%    index           Parameter index.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    parameter_name  Parameter name.
%                    
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetParameterName" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
parameter_name = char(ones(256,1,'int8'));

[err_nb, err_message, parameter_name] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParameterName', err_message, camera_set, index, parameter_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
