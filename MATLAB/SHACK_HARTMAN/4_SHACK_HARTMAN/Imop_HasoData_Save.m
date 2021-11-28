function err_message = Imop_HasoData_Save(HasoData, has_file_path, comments, session_name)

% IMOP_HASODATA_SAVE Saves a HasoData object to a .has file.
%    If file already exists, it is overwritten, provided that opening
%    succeeds. If file opening fails, an exception is thrown.
% 
%    HasoData       HasoData object adress.
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
	error('The "Imop_HasoData_Save" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, has_file_path, comments, session_name] = calllib('WaveKitRuntime', 'Imop_HasoData_Save', err_message, HasoData, has_file_path, comments, session_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
