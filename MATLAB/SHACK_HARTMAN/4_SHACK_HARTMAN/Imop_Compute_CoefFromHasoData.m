function [err_message, ModalCoeffs] = Imop_Compute_CoefFromHasoData(ComputePhaseSet, HasoData, ModalCoeffs)

% IMOP_COMPUTE_COEFFROMHASODATA Compute modal coefficients that represent the processed slopes of the input Haso Data in a given
%    basis of polynomials provided by ComputePhaseSet.
%    WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    HasoData         HasoData object adress.
%                     
%    ModalCoeffs      ModalCoef object adress. Preferences are used as input, coefficients values are updated by the processing.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_Compute_CoefFromHasoData" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Compute_CoefFromHasoData', err_message, ComputePhaseSet, HasoData, ModalCoeffs);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
