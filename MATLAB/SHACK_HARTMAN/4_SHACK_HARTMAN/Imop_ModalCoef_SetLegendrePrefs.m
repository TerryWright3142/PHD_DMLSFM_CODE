function err_message = Imop_ModalCoef_SetLegendrePrefs(ModalCoefs, nb_coeffs_total, projection_pupil_center, projection_pupil_halfsize)

% IMOP_MODALCOEF_SETLEGENDREPREFS Set the Legendre preferences for modal phase projection.
%    WARNING! ModalCoef object must be of type E_MODALCOEF_LEGENDRE
% 
%    ModalCoefs                 ModalCoefs object adress.
%                               
%    nb_coeffs_total            Number of Legendre coefficients used in the polynomial projection basis.
%                               
%    projection_pupil_center    Center of the projection pupil.
%                               Values are expressed in number of subpupils.
%                               
%    projection_pupil_halfsize  Projection pupil half size.
%                               Values are expressed in number of subpupils.
%                               
%    err_message                Error message, empty if no error occured.
%                               
% 

if nargin ~= 4
	error('The "Imop_ModalCoef_SetLegendrePrefs" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, projection_pupil_center, projection_pupil_halfsize] = calllib('WaveKitRuntime', 'Imop_ModalCoef_SetLegendrePrefs', err_message, ModalCoefs, nb_coeffs_total, projection_pupil_center, projection_pupil_halfsize);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
