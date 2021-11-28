function [err_message, ResidualHasoSlopes, Phase] = Imop_Compute_PhaseModalZonalFromCoef(ComputePhaseSet, HasoData, ModalCoeffs, ResidualHasoSlopes, Phase)

% IMOP_COMPUTE_PHASEMODALZONALFROMCOEF Not available
%    WARNING! Allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE.
% Compute phase from modal coefficients stored in ModalCoeffs given the preferences provided by ComputePhaseSet and adds
%    the residual phase computed on processed slopes of the input HasoData using the modal + zonal reconstruction.
%    Modal coeffs must have a projection pupil set in their preferences.
%    ComputePhaseSet     ComputePhaseSet object adress.
%                        
%    HasoData            HasoData object adress containing the zonal residual slopes.
%                        
%    ModalCoeffs         ModalCoef object adress.
%                        
%    ResidualHasoSlopes  HasoSlopes object adress containing the recomputed residual slopes.
%                        
%    Phase               phase object adress. Phase values and steps are expressed in um.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 5
	error('The "Imop_Compute_PhaseModalZonalFromCoef" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Compute_PhaseModalZonalFromCoef', err_message, ComputePhaseSet, HasoData, ModalCoeffs, ResidualHasoSlopes, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
