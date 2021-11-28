function [err_message, HasoEngine] = Imop_HasoEngine_NewFromConfigFile(config_file_path)

% IMOP_HASOENGINE_NEWFROMCONFIGFILE HasoEngine constructor from a Haso configuration file.
% 
%    config_file_path  Absolute path to Haso configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    HasoEngine        Pointer to HasoEngine object adress.
%                      
% 

if nargin ~= 1
	error('The "Imop_HasoEngine_NewFromConfigFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoEngine = 0;

[err_nb, err_message, HasoEngine, config_file_path] = calllib('WaveKitRuntime', 'Imop_HasoEngine_NewFromConfigFile', err_message, HasoEngine, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
