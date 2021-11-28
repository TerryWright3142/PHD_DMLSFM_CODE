function [err_message, ModalCoeffs] = Imop_ComputeSlopes_CoefFromSlopes(ComputePhaseSet, HasoSlopes, ModalCoeffs)

% IMOP_COMPUTESLOPES_COEFFROMSLOPES Compute modal coefficients that represent the processed slopes of the input Haso Data in a given
%    basis of polynomials provided by ComputePhaseSet.
%    WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    HasoSlopes       HasoData object adress.
%                     
%    ModalCoeffs      ModalCoef object adress. Preferences are used as input, coefficients values are updated by the processing.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_ComputeSlopes_CoefFromSlopes" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_CoefFromSlopes', err_message, ComputePhaseSet, HasoSlopes, ModalCoeffs);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
