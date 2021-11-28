function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(has_file_path)

% IMOP_HASOSLOPES_NEWFROMHASFILE HasoSlopes constructor from .has file
% 
%    has_file_path  Absolute path to .has file.
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    HasoSlopes     Pointer to HasoSlopes object adress.
%                   
% 

if nargin ~= 1
	error('The "Imop_HasoSlopes_NewFromHasFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes, has_file_path] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromHasFile', err_message, HasoSlopes, has_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
