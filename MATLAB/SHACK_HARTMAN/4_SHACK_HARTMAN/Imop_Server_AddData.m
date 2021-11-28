function [err_message, server] = Imop_Server_AddData(name, type)

% IMOP_SERVER_ADDDATA Configure server to support transfer of data named /p name with type /p type
% 
%    name         Data name
%                 
%    type         Data type, @see E_TYPES_T
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    server       Pointer to server object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Server_AddData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
server = 0;

[err_nb, err_message, name] = calllib('WaveKitRuntime', 'Imop_Server_AddData', err_message, server, name, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
