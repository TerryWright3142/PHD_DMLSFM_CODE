function err_message = Imop_HasoData_SetHasoSlopes(HasoData, HasoSlopesRaw)

% IMOP_HASODATA_SETHASOSLOPES Set raw HasoSlopes objects.
% 
%    HasoData       HasoData object adress.
%                   
%    HasoSlopesRaw  HasoSlopes object adress.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 2
	error('The "Imop_HasoData_SetHasoSlopes" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_SetHasoSlopes', err_message, HasoData, HasoSlopesRaw);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
