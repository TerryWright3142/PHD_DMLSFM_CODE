function [err_message, coef, index, mask] = Imop_ModalCoef_GetData(modalCoef, coef, index, mask)

% IMOP_MODALCOEF_GETDATA Get polynomial coefficients informations and values.
% 
%    modalCoef    ModalCoef object adress.
%                 
%    coef         Array of modal coefficient values.
%                 
%    index        Array of modal coefficient indices.
%                 
%    mask         Mask object adress stores as a pupil object.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 4
	error('The "Imop_ModalCoef_GetData" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, coef, index] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetData', err_message, modalCoef, coef, index, mask);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
