function [err_message, nb_coeffs_total, projection_pupil_center, projection_pupil_halfsize] = Imop_ModalCoef_GetLegendrePrefs(ModalCoefs)

% IMOP_MODALCOEF_GETLEGENDREPREFS Get preferences for phase projection from Legendre decomposition.
%    WARNING! ModalCoef object must be of type E_MODALCOEF_LEGENDRE
% 
%    ModalCoefs                 ModalCoefs object adress.
%                               
%    err_message                Error message, empty if no error occured.
%                               
%    nb_coeffs_total            Number of Legendre coefficients used in the polynomial projection basis.
%                               
%    projection_pupil_center    Center of the projection pupil.
%                               Values are expressed in number of subpupils.
%                               
%    projection_pupil_halfsize  Projection pupil half-size.
%                               Values are expressed in number of subpupils.
%                               
% 

if nargin ~= 1
	error('The "Imop_ModalCoef_GetLegendrePrefs" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_coeffs_total = 0;
projection_pupil_center = [];
projection_pupil_halfsize = [];

[err_nb, err_message, nb_coeffs_total, projection_pupil_center, projection_pupil_halfsize] = calllib('WaveKitRuntime', 'Imop_ModalCoef_GetLegendrePrefs', err_message, ModalCoefs, nb_coeffs_total, projection_pupil_center, projection_pupil_halfsize);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
