function [err_message, default_value] = Imop_CameraSet_GetParameterBooleanDefaultValue(camera_set, parameter_name)

% IMOP_CAMERASET_GETPARAMETERBOOLEANDEFAULTVALUE Camera parameter default value getter for parameter of type float.
% 
%    camera_set      CameraSet object adress.
%                    
%    parameter_name  Parameter name.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    default_value   Parameter default value.
%                    
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetParameterBooleanDefaultValue" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
default_value = 0;

[err_nb, err_message, parameter_name, default_value] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParameterBooleanDefaultValue', err_message, camera_set, parameter_name, default_value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
