function [err_message, TypePhase] = Imop_ComputePhaseSet_GetTypePhase(ComputePhaseSet)

% IMOP_COMPUTEPHASESET_GETTYPEPHASE Get phase reconstruction type of the ComputePhaseSet object.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    TypePhase        Size of the polynomial base defined in ComputePhaseSet.
%                     
% 

if nargin ~= 1
	error('The "Imop_ComputePhaseSet_GetTypePhase" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
TypePhase = 0;

[err_nb, err_message, TypePhase] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_GetTypePhase', err_message, ComputePhaseSet, TypePhase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
