function [err_message, min, max] = Imop_CameraSet_GetParameterRealLimits(camera_set, parameter_name)

% IMOP_CAMERASET_GETPARAMETERREALLIMITS Camera parameter range getter for parameter of type float.
% 
%    camera_set      CameraSet object adress.
%                    
%    parameter_name  Parameter name.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    min             Minimum value accepted.
%                    
%    max             Maximum value accepted.
%                    
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetParameterRealLimits" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
min = 0;
max = 0;

[err_nb, err_message, parameter_name, min, max] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParameterRealLimits', err_message, camera_set, parameter_name, min, max);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
