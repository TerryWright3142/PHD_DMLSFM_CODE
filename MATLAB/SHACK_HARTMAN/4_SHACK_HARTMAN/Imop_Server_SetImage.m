function err_message = Imop_Server_SetImage(server, name, data)

% IMOP_SERVER_SETIMAGE Set data corresponding to /p name.
%    WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
% 
%    server       Server object adress.
%                 
%    name         Data name
%                 
%    data         Image object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 3
	error('The "Imop_Server_SetImage" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, name] = calllib('WaveKitRuntime', 'Imop_Server_SetImage', err_message, server, name, data);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
