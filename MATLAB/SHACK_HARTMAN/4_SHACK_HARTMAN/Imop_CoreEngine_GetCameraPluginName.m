function [err_message, plugin_name] = Imop_CoreEngine_GetCameraPluginName(config_file_path)

% IMOP_COREENGINE_GETCAMERAPLUGINNAME Not available
% 
%    config_file_path  Absolute path to Haso or camera configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    plugin_name       Camera dll name.
%                      
% 

if nargin ~= 1
	error('The "Imop_CoreEngine_GetCameraPluginName" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
plugin_name = char(ones(256,1,'int8'));

[err_nb, err_message, config_file_path, plugin_name] = calllib('WaveKitRuntime', 'Imop_CoreEngine_GetCameraPluginName', err_message, config_file_path, plugin_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
