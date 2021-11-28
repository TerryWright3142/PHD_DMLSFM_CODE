function [err_message, ModalCoef] = Imop_ModalCoef_NewFromData(type, polyindex, coef, mask, size)

% IMOP_MODALCOEF_NEWFROMDATA ModalCoef constructor from reconstruction informations
%    WARNING! This method does not set the ModalCoef preferences.
% 
%    type         E_MODAL_T Polynomial basis type.
%                 
%    polyindex    Array of modal coefficient indices.
%                 
%    coef         Array of modal coefficient values.
%                 
%    mask         Mask object adress stores as a pupil object.
%                 
%    size         Size of modal coefficient array.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    ModalCoef    Pointer to ModalCoef object adress.
%                 
% 

if nargin ~= 5
	error('The "Imop_ModalCoef_NewFromData" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;

[err_nb, err_message, ModalCoef, polyindex, coef] = calllib('WaveKitRuntime', 'Imop_ModalCoef_NewFromData', err_message, ModalCoef, type, polyindex, coef, mask, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
