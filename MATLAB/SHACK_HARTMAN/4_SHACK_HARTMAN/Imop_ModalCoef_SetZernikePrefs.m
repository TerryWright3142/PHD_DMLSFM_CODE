function err_message = Imop_ModalCoef_SetZernikePrefs(ModalCoefs, normalisation, nb_coeffs_total, nb_coeffs_to_filter, coeffs_to_filter, projection_pupil_center, projection_pupil_radius)

% IMOP_MODALCOEF_SETZERNIKEPREFS Set the Zernike preferences for modal phase projection.
%    WARNING! ModalCoef object must be of type E_MODALCOEF_ZERNIKE
% 
%    ModalCoefs               ModalCoefs object adress.
%                             
%    normalisation            E_ZERNIKE_NORM_T Normalisation Phase coefficients enumeration.
%                             
%    nb_coeffs_total          Number of Zernike coefficients used in the polynomial base.
%                             
%    nb_coeffs_to_filter      Number of Zernike coefficients to be ignored in the polynomial base while projecting.
%                             
%    coeffs_to_filter         List of indices of Zernike coefficients to be ignored in the polynomial base while projecting.
%                             
%    projection_pupil_center  Center of the projection pupil.
%                             Values are expressed in number of subpupils.
%                             
%    projection_pupil_radius  Projection pupil radius.
%                             Value is expressed in number of subpupils.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 7
	error('The "Imop_ModalCoef_SetZernikePrefs" function requires 7 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, coeffs_to_filter, projection_pupil_center] = calllib('WaveKitRuntime', 'Imop_ModalCoef_SetZernikePrefs', err_message, ModalCoefs, normalisation, nb_coeffs_total, nb_coeffs_to_filter, coeffs_to_filter, projection_pupil_center, projection_pupil_radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
