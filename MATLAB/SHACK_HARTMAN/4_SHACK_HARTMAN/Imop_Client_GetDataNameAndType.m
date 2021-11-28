function [err_message, data_name, data_type] = Imop_Client_GetDataNameAndType(client, index)

% IMOP_CLIENT_GETDATANAMEANDTYPE Slopes getter
% 
%    client       Client object adress.
%                 
%    index        Data index (must be between 0 and data_number - 1).
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    data_name    Data name at specified index
%                 
%    data_type    Data type at specified index
%                 
% 

if nargin ~= 2
	error('The "Imop_Client_GetDataNameAndType" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
data_name = char(ones(256,1,'int8'));
data_type = 0;

[err_nb, err_message, data_name, data_type] = calllib('WaveKitRuntime', 'Imop_Client_GetDataNameAndType', err_message, client, index, data_name, data_type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
