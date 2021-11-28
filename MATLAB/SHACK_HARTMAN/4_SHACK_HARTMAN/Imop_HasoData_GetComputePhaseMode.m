function [err_message, TypePhase] = Imop_HasoData_GetComputePhaseMode(HasoData)

% IMOP_HASODATA_GETCOMPUTEPHASEMODE Not available
% Get phase reconstruction mode.
%    HasoData     HasoData object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    TypePhase    E_COMPUTEPHASESET_T phase reconstruction mode enumeration.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoData_GetComputePhaseMode" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
TypePhase = 0;

[err_nb, err_message, TypePhase] = calllib('WaveKitRuntime', 'Imop_HasoData_GetComputePhaseMode', err_message, HasoData, TypePhase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
