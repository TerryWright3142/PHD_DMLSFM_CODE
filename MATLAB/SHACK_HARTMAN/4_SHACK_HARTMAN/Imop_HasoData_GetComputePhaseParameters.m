function [err_message, ComputePhaseSet, ModalCoef] = Imop_HasoData_GetComputePhaseParameters(HasoData, ComputePhaseSet, ModalCoef)

% IMOP_HASODATA_GETCOMPUTEPHASEPARAMETERS Not available
%    WARNING! allowed E_COMPUTEPHASESET_T value : Any.
% Get ComputePhaseSet object.
%    HasoData         HasoData object adress.
%                     
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    ModalCoef        Modal coefficients object adress
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_HasoData_GetComputePhaseParameters" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_GetComputePhaseParameters', err_message, HasoData, ComputePhaseSet, ModalCoef);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
