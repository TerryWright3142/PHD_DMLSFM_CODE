function err_message = Imop_HasoSlopes_SaveToFile(HasoSlopes, has_file_path, comments, session_name)

% IMOP_HASOSLOPES_SAVETOFILE Save HasoSlopes to a .has file.
% 
%    HasoSlopes     HasoSlopes object adress.
%                   
%    has_file_path  Absolute path to the .has file.
%                   
%    comments       Comments.
%                   
%    session_name   Session name.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 4
	error('The "Imop_HasoSlopes_SaveToFile" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, has_file_path, comments, session_name] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_SaveToFile', err_message, HasoSlopes, has_file_path, comments, session_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
