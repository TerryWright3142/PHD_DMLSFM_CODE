function Imop_Haso_DLLVersion()

% IMOP_HASO_DLLVERSION Not available
% 
% 

if nargin ~= 0
	error('The "Imop_Haso_DLLVersion" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Haso_DLLVersion');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
