function err_message = Imop_CorrDataManager_SetCommandMatrixPrefs(corrdata_manager, nb_kept_modes, tilt_filtering)

% IMOP_CORRDATAMANAGER_SETCOMMANDMATRIXPREFS Command matrix computation preferences.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    nb_kept_modes     Number of influences (starting from the highest) to keep.
%                      
%    tilt_filtering    If True, computed command matrix does not take tilt into account.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_SetCommandMatrixPrefs" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_SetCommandMatrixPrefs', err_message, corrdata_manager, nb_kept_modes, tilt_filtering);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
