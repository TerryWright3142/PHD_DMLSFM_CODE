function [err_message, type] = Imop_CameraSet_GetParameterType(camera_set, parameter_name)

% IMOP_CAMERASET_GETPARAMETERTYPE Camera parameter type getter given its name which should have been read with Imop_CameraSet_GetParameterName.
% 
%    camera_set      CameraSet object adress.
%                    
%    parameter_name  Parameter name.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    type            Parameter type value, @see E_TYPES_T
%                    
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetParameterType" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
type = 0;

[err_nb, err_message, parameter_name, type] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParameterType', err_message, camera_set, parameter_name, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
