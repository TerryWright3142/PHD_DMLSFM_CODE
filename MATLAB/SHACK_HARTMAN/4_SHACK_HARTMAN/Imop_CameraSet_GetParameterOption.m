function [err_message, is_settable, is_gettable, has_default_value, has_limits, is_string_enum, is_settable_on_fly, is_gettable_on_fly] = Imop_CameraSet_GetParameterOption(camera_set, parameter_name)

% IMOP_CAMERASET_GETPARAMETEROPTION Camera parameter options getter given its name which should have been read with Imop_CameraSet_GetParameterName.
% 
%    camera_set          CameraSet object adress.
%                        
%    parameter_name      Parameter name.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    is_settable         Parameter value is writeable.
%                        
%    is_gettable         Parameter value is readable.
%                        
%    has_default_value   Parameter has a default value.
%                        
%    has_limits          If parameter is a number, its value is to be selected between a min and a max value.
%                        
%    is_string_enum      If parameter is a string, its value is to be selected in a finite set of values.
%                        
%    is_settable_on_fly  Parameter is writeable while camera is running, and a value change is taken into account asap.
%                        
%    is_gettable_on_fly  Parameter is readable while camera is running, and the return value will be the one currently used.
%                        
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetParameterOption" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
is_settable = 0;
is_gettable = 0;
has_default_value = 0;
has_limits = 0;
is_string_enum = 0;
is_settable_on_fly = 0;
is_gettable_on_fly = 0;

[err_nb, err_message, parameter_name, is_settable, is_gettable, has_default_value, has_limits, is_string_enum, is_settable_on_fly, is_gettable_on_fly] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParameterOption', err_message, camera_set, parameter_name, is_settable, is_gettable, has_default_value, has_limits, is_string_enum, is_settable_on_fly, is_gettable_on_fly);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
