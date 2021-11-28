function [err_message, HasoData] = Imop_HasoData_NewFromFile(has_file_path)

% IMOP_HASODATA_NEWFROMFILE HasoData constructor from a .has file. If file opening fails, an exception is thrown.
% 
%    has_file_path  Absolute path to .has file.
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    HasoData       Pointer to HasoData object adress.
%                   
% 

if nargin ~= 1
	error('The "Imop_HasoData_NewFromFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoData = 0;

[err_nb, err_message, HasoData, has_file_path] = calllib('WaveKitRuntime', 'Imop_HasoData_NewFromFile', err_message, HasoData, has_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
