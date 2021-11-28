function [err_message, ModalCoeffs, Phase] = Imop_ComputeSlopes_PhaseModal(ComputePhaseSet, HasoSlopes, ModalCoeffs, Phase)

% IMOP_COMPUTESLOPES_PHASEMODAL Compute phase from slopes via modal coefficients in a given
%    basis of polynomials provided by ComputePhaseSet.
%    WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_LEGENDRE, E_COMPUTEPHASESET_MODAL_ZERNIKE.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    HasoSlopes       HasoSlopes object adress.
%                     
%    ModalCoeffs      ModalCoef object adress. Preferences are used as input, coefficients values are updated by the processing.
%                     
%    Phase            phase object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 4
	error('The "Imop_ComputeSlopes_PhaseModal" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_PhaseModal', err_message, ComputePhaseSet, HasoSlopes, ModalCoeffs, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
