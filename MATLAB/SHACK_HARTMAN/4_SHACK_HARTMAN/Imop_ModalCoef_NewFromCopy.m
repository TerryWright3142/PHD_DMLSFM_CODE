function [err_message, ModalCoef] = Imop_ModalCoef_NewFromCopy(copy)

% IMOP_MODALCOEF_NEWFROMCOPY ModalCoef constructor from copy
% 
%    copy         ModalCoef object to copy.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    ModalCoef    Pointer to ModalCoef object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;

[err_nb, err_message, ModalCoef] = calllib('WaveKitRuntime', 'Imop_ModalCoef_NewFromCopy', err_message, ModalCoef, copy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
