function [err_message, HasoSlopes, HasoSlopesRaw] = Imop_HasoData_GetHasoSlopes(HasoData, HasoSlopes, HasoSlopesRaw)

% IMOP_HASODATA_GETHASOSLOPES Get raw and processed HasoSlopes objects.
% 
%    HasoData       HasoData object adress.
%                   
%    HasoSlopes     processed HasoSlopes object adress.
%                   
%    HasoSlopesRaw  raw HasoSlopes object adress.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin < 2
	error('The "Imop_HasoData_GetHasoSlopes" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_HasoData_GetHasoSlopes" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	HasoSlopesRaw=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_GetHasoSlopes', err_message, HasoData, HasoSlopes, HasoSlopesRaw);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
