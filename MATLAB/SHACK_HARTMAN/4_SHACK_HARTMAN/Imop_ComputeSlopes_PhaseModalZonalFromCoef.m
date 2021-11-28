function [err_message, ResidualHasoSlopes, Phase] = Imop_ComputeSlopes_PhaseModalZonalFromCoef(ComputePhaseSet, HasoSlopes, ModalCoeffs, ResidualHasoSlopes, Phase)

% IMOP_COMPUTESLOPES_PHASEMODALZONALFROMCOEF Compute phase from modal coefficients stored in ModalCoeffs given the preferences provided by ComputePhaseSet and adds
%    the residual phase computed on input HasoSlopes using the modal + zonal reconstruction.
%    Modal coeffs must have a projection pupil set in their preferences.
%    WARNING! Allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE.
% 
%    ComputePhaseSet     ComputePhaseSet object adress.
%                        
%    HasoSlopes          HasoSlopes object adress containing the input zonal residual slopes.
%                        
%    ModalCoeffs         ModalCoef object adress.
%                        
%    ResidualHasoSlopes  HasoSlopes object adress containing the recomputed residual slopes.
%                        
%    Phase               phase object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 5
	error('The "Imop_ComputeSlopes_PhaseModalZonalFromCoef" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_PhaseModalZonalFromCoef', err_message, ComputePhaseSet, HasoSlopes, ModalCoeffs, ResidualHasoSlopes, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
