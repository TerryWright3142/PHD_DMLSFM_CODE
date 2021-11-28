function Imop_GetModuleVersion()

% IMOP_GETMODULEVERSION Not available
% 
% 

if nargin ~= 0
	error('The "Imop_GetModuleVersion" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_GetModuleVersion');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
