function [err_message, ModalCoef, comments] = Imop_ModalCoef_NewFromFile(type, coefs_file_path)

% IMOP_MODALCOEF_NEWFROMFILE ModalCoef constructor from modal coefficients file
% 
%    type             E_MODAL_T Polynomial basis type.
%                     
%    coefs_file_path  Modal coefficients file path.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    ModalCoef        Pointer to ModalCoef object adress.
%                     
%    comments         Comment
%                     
% 

if nargin ~= 2
	error('The "Imop_ModalCoef_NewFromFile" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;
comments = char(ones(256,1,'int8'));

[err_nb, err_message, ModalCoef, coefs_file_path, comments] = calllib('WaveKitRuntime', 'Imop_ModalCoef_NewFromFile', err_message, ModalCoef, type, coefs_file_path, comments);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
