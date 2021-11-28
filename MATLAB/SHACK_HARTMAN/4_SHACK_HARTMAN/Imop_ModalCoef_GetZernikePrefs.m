function [err_message, normalisation, nb_coeffs_total, nb_coeffs_to_filter, coeffs_to_filter, projection_pupil_center, projection_pupil_radius] = Imop_ModalCoef_GetZernikePrefs(ModalCoefs, coeffs_to_filter)

% IMOP_MODALCOEF_GETZERNIKEPREFS Get preferences for phase projection from Zernike decomposition.
%    WARNING! ModalCoef object must be of type E_MODALCOEF_ZERNIKE
% 
%    ModalCoefs               ModalCoefs object adress.
%                             
%    coeffs_to_filter         List of indices of Zernike coefficients ignored in the polynomial base while projecting.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    normalisation            E_ZERNIKE_NORM_T Normalisation Phase coefficients enumeration.
%                             
%    nb_coeffs_total          Number of the Zernike coefficients used in the polynomial base.
%                             
%    nb_coeffs_to_filter      Number of Zernike coefficients ignored in the polynomial base while projecting.
%                             
%    projection_pupil_center  Center of the projection pupil.
%                             Values are expressed in number of subpupils.
%                             
%    projection_pupil_radius  Projection pupil radius.
%                             Value is expressed in number of subpupils.
%                             
% 

if nargin ~= 2
	error('The "Imop_ModalCoef_GetZernikePrefs" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
normalisation = 0;
nb_coeffs_total = 0;
nb_coeffs_to_filter = 0;
projection_pupil_center = [];
projection_pupil_radius = 0;

[err_nb, err_message, normalisation, nb_coeffs_total, nb_coeffs_to_filter, coeffs_to_filter, projection_pupil_center, projection_pupil_radius] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetZernikePrefs', err_message, ModalCoefs, normalisation, nb_coeffs_total, nb_coeffs_to_filter, coeffs_to_filter, projection_pupil_center, projection_pupil_radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
