function [err_message, HasoSlopes] = Imop_ComputeSlopes_SlopesFromCoef(ComputePhaseSet, ModalCoeffs, HasoSlopes)

% IMOP_COMPUTESLOPES_SLOPESFROMCOEF *Compute slopes from modal coefficients that represent them in
%    a given basis of polynomials provided by ComputePhaseSet.
%    Modal coeffs must have a projection pupil set in their preferences.
%    WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_LEGENDRE, E_COMPUTEPHASESET_MODAL_ZERNIKE.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    ModalCoeffs      ModalCoef object adress.
%                     
%    HasoSlopes       HasoSlopes object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_ComputeSlopes_SlopesFromCoef" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_SlopesFromCoef', err_message, ComputePhaseSet, ModalCoeffs, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
