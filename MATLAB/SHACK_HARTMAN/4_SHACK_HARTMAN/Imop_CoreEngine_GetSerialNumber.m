function Imop_CoreEngine_GetSerialNumber()

% IMOP_COREENGINE_GETSERIALNUMBER Not available
% 
% 

if nargin ~= 0
	error('The "Imop_CoreEngine_GetSerialNumber" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_CoreEngine_GetSerialNumber');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
