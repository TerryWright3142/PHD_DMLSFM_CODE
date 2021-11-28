function [err_message, sequence_size] = Imop_HasoData_GetSequenceSize(sequence_file_path)

% IMOP_HASODATA_GETSEQUENCESIZE Get the size of the HasoData array from file.
% 
%    sequence_file_path  Absolute path to sequence file.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    sequence_size       Sequence length (number of HasoData).
%                        
% 

if nargin ~= 1
	error('The "Imop_HasoData_GetSequenceSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
sequence_size = 0;

[err_nb, err_message, sequence_file_path, sequence_size] = calllib('WaveKitRuntime', 'Imop_HasoData_GetSequenceSize', err_message, sequence_file_path, sequence_size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
