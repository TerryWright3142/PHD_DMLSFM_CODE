function err_message = Imop_CorrDataManager_SaveBackupFile(corrdata_manager, backup_file_path, comment)

% IMOP_CORRDATAMANAGER_SAVEBACKUPFILE Dumps CorrDataManager data to file.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    backup_file_path  Absolute path to CorrDataManager backup file.
%                      
%    comment           User-defined comment to write to backup file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_SaveBackupFile" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, backup_file_path, comment] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_SaveBackupFile', err_message, corrdata_manager, backup_file_path, comment);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
