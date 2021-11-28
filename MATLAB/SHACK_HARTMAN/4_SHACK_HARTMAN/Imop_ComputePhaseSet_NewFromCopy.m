function [err_message, ComputePhaseSet, copy] = Imop_ComputePhaseSet_NewFromCopy()

% IMOP_COMPUTEPHASESET_NEWFROMCOPY Imop_ComputePhaseSet constructor from copy
% 
%    err_message      Error message, empty if no error occured.
%                     
%    ComputePhaseSet  Pointer to ComputePhaseSet object adress.
%                     
%    copy             ComputePhaseSet object to copy.
%                     
% 

if nargin ~= 0
	error('The "Imop_ComputePhaseSet_NewFromCopy" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ComputePhaseSet = 0;
copy = 0;

[err_nb, err_message, ComputePhaseSet] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_NewFromCopy', err_message, ComputePhaseSet, copy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
