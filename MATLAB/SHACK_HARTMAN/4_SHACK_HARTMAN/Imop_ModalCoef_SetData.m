function [err_message, coef, index] = Imop_ModalCoef_SetData(modalCoef, coef, index, size, mask)

% IMOP_MODALCOEF_SETDATA Set polynomial coefficients informations and values.
% 
%    modalCoef    ModalCoef object adress.
%                 
%    size         Size of the coefficient array.
%                 
%    mask         Mask object adress stores as a pupil object.
%                 
%    coef         Array of modal coefficient values.
%                 
%    index        Array of modal coefficient indices.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 5
	error('The "Imop_ModalCoef_SetData" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, coef, index] = calllib('WaveKitRuntime', 'Imop_ModalCoef_SetData', err_message, modalCoef, coef, index, size, mask);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
