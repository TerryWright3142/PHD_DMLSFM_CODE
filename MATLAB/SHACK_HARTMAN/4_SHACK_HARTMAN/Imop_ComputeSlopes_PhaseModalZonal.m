function [err_message, ModalCoeffs, ResidualHasoSlopes, Phase] = Imop_ComputeSlopes_PhaseModalZonal(ComputePhaseSet, HasoSlopes, ModalCoeffs, ResidualHasoSlopes, Phase)

% IMOP_COMPUTESLOPES_PHASEMODALZONAL Compute phase from slopes using both zonal and modal reconstruction.
%    WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE.
% Computes phase from slopes thanks to an algorithm that
%    combines the results of modal and zonal phase processors.
%    It first computes
%    modal coefficients in the requested polynomial basis using given modal
%    preferences. From those coefficients, it reconstructs slopes.
%    The difference HasoSlopes between input slopes and reconstructed slopes is called residual slopes.
%    Output phase is obtained by summing modal phase obtained from modal
%    coefficients using given modal parameters, and zonal phase obtained from
%    residual slopes using zonal parameters consisting of given zonal preferences
%    and a default-constructed zonal filter.
%    Modal coeffs must have a projection pupil set :
%    ComputePhaseSet     ComputePhaseSet object adress.
%                        
%    HasoSlopes          HasoSlopes object adress containing the input slopes.
%                        
%    ModalCoeffs         ModalCoef object adress. Preferences are used as input, coefficients values are updated by the processing.
%                        
%    ResidualHasoSlopes  HasoSlopes object adress containing the residual slopes.
%                        
%    Phase               Phase object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 5
	error('The "Imop_ComputeSlopes_PhaseModalZonal" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_PhaseModalZonal', err_message, ComputePhaseSet, HasoSlopes, ModalCoeffs, ResidualHasoSlopes, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
