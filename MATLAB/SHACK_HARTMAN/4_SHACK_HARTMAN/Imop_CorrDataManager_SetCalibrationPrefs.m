function err_message = Imop_CorrDataManager_SetCalibrationPrefs(corrdata_manager, push_pull_value)

% IMOP_CORRDATAMANAGER_SETCALIBRATIONPREFS Calibration process supposes back and forth moves on all actuators.
% Use this function to calibrate the amplitude of these moves.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    push_pull_value   In case experiment type is "push-pull" (type 0), indicates the actuators displacement amplitude.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_SetCalibrationPrefs" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_SetCalibrationPrefs', err_message, corrdata_manager, push_pull_value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
