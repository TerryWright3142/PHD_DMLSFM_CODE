function err_message = Imop_Client_New(client, ip, port, time_out)

% IMOP_CLIENT_NEW Client constructor from server ip adress and server port.
% 
%    client       Client object adress.
%                 
%    ip           Server ip adress.
%                 
%    port         Server port.
%                 
%    time_out     Timeout.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 4
	error('The "Imop_Client_New" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, client, ip] = calllib('WaveKitRuntime', 'Imop_Client_New', err_message, client, ip, port, time_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
