function [err_message, HasoData] = Imop_HasoData_New(HasoSlopes)

% IMOP_HASODATA_NEW HasoData constructor from HasoSlopes
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    HasoData     Pointer to HasoData object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoData_New" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoData = 0;

[err_nb, err_message, HasoData] = calllib('WaveKitRuntime', 'Imop_HasoData_New', err_message, HasoData, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
