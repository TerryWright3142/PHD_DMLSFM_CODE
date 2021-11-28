function [err_message, corrdata_manager] = Imop_CorrDataManager_NewFromBackupFile(haso_config_file_path, interaction_matrix_file_path)

% IMOP_CORRDATAMANAGER_NEWFROMBACKUPFILE CorrDataManager constructor from a CorrDataManager dump file.
% 
%    haso_config_file_path         Absolute path to Haso configuration file.
%                                  
%    interaction_matrix_file_path  Absolute path to CorrDataManager dump file.
%                                  
%    err_message                   Error message, empty if no error occured.
%                                  
%    corrdata_manager              Pointer to CorrDataManager object adress.
%                                  
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_NewFromBackupFile" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
corrdata_manager = 0;

[err_nb, err_message, corrdata_manager, haso_config_file_path, interaction_matrix_file_path] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_NewFromBackupFile', err_message, corrdata_manager, haso_config_file_path, interaction_matrix_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
