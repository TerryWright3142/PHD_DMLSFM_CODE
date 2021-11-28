function [err_message, server] = Imop_Server_Start()

% IMOP_SERVER_START Start server
% 
%    err_message  Error message, empty if no error occured.
%                 
%    server       Pointer to server object adress.
%                 
% 

if nargin ~= 0
	error('The "Imop_Server_Start" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
server = 0;

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Server_Start', err_message, server);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
