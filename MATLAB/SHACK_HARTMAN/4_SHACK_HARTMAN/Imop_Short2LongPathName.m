function Imop_Short2LongPathName()

% IMOP_SHORT2LONGPATHNAME Not available
% 
% 

if nargin ~= 0
	error('The "Imop_Short2LongPathName" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Short2LongPathName');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
