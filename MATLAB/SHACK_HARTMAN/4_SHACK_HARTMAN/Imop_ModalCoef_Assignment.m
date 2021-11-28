function err_message = Imop_ModalCoef_Assignment(ModalCoef_dst, ModalCoef_src)

% IMOP_MODALCOEF_ASSIGNMENT ModalCoef deep copy.
% 
%    ModalCoef_dst  ModalCoef object adress to assign.
%                   
%    ModalCoef_src  ModalCoef object adress to copy.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 2
	error('The "Imop_ModalCoef_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ModalCoef_Assignment', err_message, ModalCoef_dst, ModalCoef_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
