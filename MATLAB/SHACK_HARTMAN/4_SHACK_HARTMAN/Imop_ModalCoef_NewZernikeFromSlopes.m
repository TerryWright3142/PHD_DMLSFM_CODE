function [err_message, ModalCoef] = Imop_ModalCoef_NewZernikeFromSlopes(normalisation, nb_coeffs_total, slopes)

% IMOP_MODALCOEF_NEWZERNIKEFROMSLOPES ModalCoef constructor from slopes object.
%    Uses the auto-detected circular inscribed pupil.
%    WARNING! This method does not handle central occulation and returns the nb_coeffs_total first Zernike coefficients unfiltered.
% 
%    normalisation    E_ZERNIKE_NORM_T Normalisation Phase coefficients enumeration
%                     
%    nb_coeffs_total  Number of Zernike coefficients used in the polynomial base.
%                     
%    slopes           Adress of HasoSlopes object
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    ModalCoef        Pointer to ModalCoef object adress.
%                     
% 

if nargin ~= 3
	error('The "Imop_ModalCoef_NewZernikeFromSlopes" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ModalCoef = 0;

[err_nb, err_message, ModalCoef] = calllib('WaveKitRuntime', 'Imop_ModalCoef_NewZernikeFromSlopes', err_message, ModalCoef, normalisation, nb_coeffs_total, slopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
