function err_message = Imop_CorrDataManager_LoadBackupFile(corrdata_manager, backup_file_path)

% IMOP_CORRDATAMANAGER_LOADBACKUPFILE Load data extracted from a CorrDataManager backup file into current CorrDataManager object.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    backup_file_path  Absolute path to CorrDataManager backup file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_LoadBackupFile" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, backup_file_path] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_LoadBackupFile', err_message, corrdata_manager, backup_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
