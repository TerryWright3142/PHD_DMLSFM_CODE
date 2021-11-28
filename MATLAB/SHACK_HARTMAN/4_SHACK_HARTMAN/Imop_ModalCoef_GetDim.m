function [err_message, size] = Imop_ModalCoef_GetDim(modalCoef)

% IMOP_MODALCOEF_GETDIM Retrieve polynomial coefficients count.
% 
%    modalCoef    ModalCoef object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    size         Number of modal coefficients.
%                 
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_GetDim" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = 0;

[err_nb, err_message, size] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetDim', err_message, modalCoef, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
