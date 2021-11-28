function [err_message, ComputePhaseSet] = Imop_ComputePhaseSet_NewFromHasoData(HasoData)

% IMOP_COMPUTEPHASESET_NEWFROMHASODATA Imop_ComputePhaseSet constructor from the processed slopes of a HasoData.
%    Provide a pointer to a ComputePhaseSet object adress.
% 
%    HasoData         HasoData object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    ComputePhaseSet  Pointer to ComputePhaseSet object adress.
%                     
% 

if nargin ~= 1
	error('The "Imop_ComputePhaseSet_NewFromHasoData" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ComputePhaseSet = 0;

[err_nb, err_message, ComputePhaseSet] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_NewFromHasoData', err_message, ComputePhaseSet, HasoData);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
