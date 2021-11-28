function [err_message, ComputePhaseSet] = Imop_ComputePhaseSet_NewFromTypePhase(TypePhase)

% IMOP_COMPUTEPHASESET_NEWFROMTYPEPHASE Imop_ComputePhaseSet constructor from E_COMPUTEPHASESET_T value.
%    WARNING! See E_COMPUTEPHASESET_T for authorized values.
% 
%    TypePhase        E_COMPUTEPHASESET_T Phase reconstruction mode.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    ComputePhaseSet  Pointer to ComputePhaseSet object adress.
%                     
% 

if nargin ~= 1
	error('The "Imop_ComputePhaseSet_NewFromTypePhase" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ComputePhaseSet = 0;

[err_nb, err_message, ComputePhaseSet] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_NewFromTypePhase', err_message, ComputePhaseSet, TypePhase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
