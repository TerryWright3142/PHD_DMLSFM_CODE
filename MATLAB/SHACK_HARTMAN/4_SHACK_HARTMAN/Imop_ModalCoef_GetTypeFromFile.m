function [err_message, type] = Imop_ModalCoef_GetTypeFromFile(coefs_file_path)

% IMOP_MODALCOEF_GETTYPEFROMFILE Retrieve polynomial coefficients type from file (no modal coefficient object needed).
% 
%    coefs_file_path  Modal coefficients file path.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    type             type of modal coefficients.
%                     
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_GetTypeFromFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
type = 0;

[err_nb, err_message, coefs_file_path, type] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetTypeFromFile', err_message, coefs_file_path, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
