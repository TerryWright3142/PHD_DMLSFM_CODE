function [err_message, value] = Imop_Camera_GetParameterReal(Camera, parameter_name)

% IMOP_CAMERA_GETPARAMETERREAL Camera parameter getter for parameter of type E_TYPE_REAL.
% 
%    Camera          Camera object adress.
%                    
%    parameter_name  Name of the parameter.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    value           Value of the parameter.
%                    
% 

if nargin ~= 2
	error('The "Imop_Camera_GetParameterReal" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
value = 0;

[err_nb, err_message, parameter_name, value] = calllib('WaveKitRuntime', 'Imop_Camera_GetParameterReal', err_message, Camera, parameter_name, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
