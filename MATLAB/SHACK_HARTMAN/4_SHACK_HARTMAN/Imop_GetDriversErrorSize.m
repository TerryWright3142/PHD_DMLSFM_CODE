function Imop_GetDriversErrorSize()

% IMOP_GETDRIVERSERRORSIZE Not available
% 
% 

if nargin ~= 0
	error('The "Imop_GetDriversErrorSize" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_GetDriversErrorSize');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
