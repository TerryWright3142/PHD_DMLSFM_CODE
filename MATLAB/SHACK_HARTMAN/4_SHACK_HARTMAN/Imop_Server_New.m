function [err_message, server] = Imop_Server_New(config_file_path, port)

% IMOP_SERVER_NEW Server constructor from configuration file and port
% 
%    config_file_path  Absolute path to haso configuration file.
%                      
%    port              Port value.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    server            Pointer to server object adress.
%                      
% 

if nargin ~= 2
	error('The "Imop_Server_New" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
server = 0;

[err_nb, err_message, server, config_file_path] = calllib('WaveKitRuntime', 'Imop_Server_New', err_message, server, config_file_path, port);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
