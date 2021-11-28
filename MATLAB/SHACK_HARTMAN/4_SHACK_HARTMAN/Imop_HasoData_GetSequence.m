function [err_message, HasoData] = Imop_HasoData_GetSequence(HasoData, sequence_file_path)

% IMOP_HASODATA_GETSEQUENCE Load a HasoData array from file.
% 
%    sequence_file_path  Absolute path to sequence file.
%                        
%    HasoData            Array of HasoData object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 2
	error('The "Imop_HasoData_GetSequence" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, HasoData, sequence_file_path] = calllib('WaveKitRuntime', 'Imop_HasoData_GetSequence', err_message, HasoData, sequence_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
