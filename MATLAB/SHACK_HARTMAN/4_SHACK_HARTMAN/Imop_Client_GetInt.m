function [err_message, data, data_id] = Imop_Client_GetInt(client, data_name)

% IMOP_CLIENT_GETINT Slopes getter
% 
%    client       Client object adress.
%                 
%    data_name    Data name.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    data         Data content.
%                 
%    data_id      Data content id.
%                 
% 

if nargin ~= 2
	error('The "Imop_Client_GetInt" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
data = 0;
data_id = 0;

[err_nb, err_message, data_name, data, data_id] = calllib('WaveKitRuntime', 'Imop_Client_GetInt', err_message, client, data_name, data, data_id);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
