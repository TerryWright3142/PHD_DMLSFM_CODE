function [err_message, data_number] = Imop_Client_GetDataNumber(client)

% IMOP_CLIENT_GETDATANUMBER Slopes getter
% 
%    client       Client object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    data_number  Number of data server can send (useful to allocate data names and types arrays).
%                 
% 

if nargin ~= 1
	error('The "Imop_Client_GetDataNumber" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
data_number = 0;

[err_nb, err_message, data_number] = calllib('WaveKitRuntime', 'Imop_Client_GetDataNumber', err_message, client, data_number);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
