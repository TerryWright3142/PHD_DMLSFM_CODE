function [err_message, corrdata_manager] = Imop_CorrDataManager_NewFromConfigsFiles(haso_config_file_path, wfc_config_file_path)

% IMOP_CORRDATAMANAGER_NEWFROMCONFIGSFILES CorrDataManager constructor from a Haso configuration file and a wavefront configuration file.
% 
%    haso_config_file_path  Absolute path to Haso configuration file.
%                           
%    wfc_config_file_path   Absolute path to WavefrontCorrector configuration file.
%                           
%    err_message            Error message, empty if no error occured.
%                           
%    corrdata_manager       Pointer to CorrDataManager object adress.
%                           
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_NewFromConfigsFiles" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
corrdata_manager = 0;

[err_nb, err_message, corrdata_manager, haso_config_file_path, wfc_config_file_path] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_NewFromConfigsFiles', err_message, corrdata_manager, haso_config_file_path, wfc_config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
