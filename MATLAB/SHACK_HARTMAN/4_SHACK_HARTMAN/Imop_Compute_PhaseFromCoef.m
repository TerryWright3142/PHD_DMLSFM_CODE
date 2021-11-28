function [err_message, Phase] = Imop_Compute_PhaseFromCoef(ComputePhaseSet, ModalCoeffs, Phase)

% IMOP_COMPUTE_PHASEFROMCOEF Compute phase from modal coefficients in a given
%    basis of polynomials provided by ComputePhaseSet.
%    WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL.
% Modal coeffs must have a projection pupil set :
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    ModalCoeffs      ModalCoef object adress.
%                     
%    Phase            phase object adress. Phase values are expressed in um.
%                     Phase size and steps are set from ModalCoef object (Pupil object size).
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_Compute_PhaseFromCoef" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Compute_PhaseFromCoef', err_message, ComputePhaseSet, ModalCoeffs, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
