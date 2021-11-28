function [err_message, ModalCoef] = Imop_ModalCoef_NewLegendreFromSlopes(nb_coeffs_total, slopes)

% IMOP_MODALCOEF_NEWLEGENDREFROMSLOPES ModalCoef constructor from slopes object.
%    Uses the auto-detected square inscribed pupil.
%    WARNING! This method does not handle central occulation and returns the nb_coeffs_total first Legendre coefficients unfiltered.
% 
%    nb_coeffs_total  Number of Legendre coefficients used in the polynomial base.
%                     
%    slopes           Adress of HasoSlopes object
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    ModalCoef        Pointer to ModalCoef object adress.
%                     
% 

if nargin ~= 2
	error('The "Imop_ModalCoef_NewLegendreFromSlopes" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;

[err_nb, err_message, ModalCoef] = calllib('WaveKitRuntime', 'Imop_ModalCoef_NewLegendreFromSlopes', err_message, ModalCoef, nb_coeffs_total, slopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
