function [err_message, data, data_id] = Imop_Client_GetImage(client, data_name, data)

% IMOP_CLIENT_GETIMAGE Slopes getter
% 
%    client       Client object adress.
%                 
%    data_name    Data name.
%                 
%    data         Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    data_id      Data content id.
%                 
% 

if nargin ~= 3
	error('The "Imop_Client_GetImage" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
data_id = 0;

[err_nb, err_message, data_name, data_id] = calllib('WaveKitRuntime', 'Imop_Client_GetImage', err_message, client, data_name, data, data_id);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
