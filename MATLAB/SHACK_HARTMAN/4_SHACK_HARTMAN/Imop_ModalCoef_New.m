function [err_message, ModalCoef] = Imop_ModalCoef_New(type)

% IMOP_MODALCOEF_NEW ModalCoef constructor
% 
%    type         E_MODAL_T Polynomial basis type.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    ModalCoef    Pointer to ModalCoef object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_New" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;

[err_nb, err_message, ModalCoef] = calllib('WaveKitRuntime', 'Imop_ModalCoef_New', err_message, ModalCoef, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
