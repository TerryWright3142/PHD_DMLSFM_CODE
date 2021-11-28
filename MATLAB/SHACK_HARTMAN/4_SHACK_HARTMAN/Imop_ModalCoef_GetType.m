function [err_message, type] = Imop_ModalCoef_GetType(modalCoef)

% IMOP_MODALCOEF_GETTYPE Retrieve polynomial coefficients type.
% 
%    modalCoef    ModalCoef object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    type         type of modal coefficients.
%                 
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_GetType" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
type = 0;

[err_nb, err_message, type] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetType', err_message, modalCoef, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
