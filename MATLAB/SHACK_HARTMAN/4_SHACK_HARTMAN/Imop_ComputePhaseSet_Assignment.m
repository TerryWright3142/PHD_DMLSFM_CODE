function err_message = Imop_ComputePhaseSet_Assignment(ComputePhaseSet_dst, ComputePhaseSet_src)

% IMOP_COMPUTEPHASESET_ASSIGNMENT Deep copy
% 
%    ComputePhaseSet_dst  ComputePhaseSet object adress to assign.
%                         
%    ComputePhaseSet_src  ComputePhaseSet object adress to copy.
%                         
%    err_message          Error message, empty if no error occured.
%                         
% 

if nargin ~= 2
	error('The "Imop_ComputePhaseSet_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_Assignment', err_message, ComputePhaseSet_dst, ComputePhaseSet_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
