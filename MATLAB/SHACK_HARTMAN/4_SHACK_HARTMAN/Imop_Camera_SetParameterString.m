function err_message = Imop_Camera_SetParameterString(camera, parameter_name, value)

% IMOP_CAMERA_SETPARAMETERSTRING camera parameter setter for parameter of type E_TYPE_STRING.
% 
%    camera          camera object adress.
%                    
%    parameter_name  Name of the parameter.
%                    
%    value           Value of the parameter.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 3
	error('The "Imop_Camera_SetParameterString" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, parameter_name, value] = calllib('WaveKitRuntime', 'Imop_Camera_SetParameterString', err_message, camera, parameter_name, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
