function [err_message, first_command, second_command] = Imop_CorrDataManager_GetCalibrationCommands(corrdata_manager, actuator_index, first_command, second_command)

% IMOP_CORRDATAMANAGER_GETCALIBRATIONCOMMANDS Get the two wavefront corrector commands corresponding to the actuator actuator_index calibration.
% Command application must be performed using the functions of WFC.
%    Corresponding WFC must be computed on appropriate WFC captured by the Haso sensor,
%    Function returns an error if actuator is invalid. If so, please do not move the actuator and continue with the next one.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    actuator_index    Index of the actuator.
%                      
%    first_command     Wavefront corrector commands associated to the first move (push / positive displacement) of index actuator calibration.
%                      
%    second_command    Wavefront corrector commands associated to the second move (pull / negative displacement) of index actuator calibration.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 4
	error('The "Imop_CorrDataManager_GetCalibrationCommands" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, first_command, second_command] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetCalibrationCommands', err_message, corrdata_manager, actuator_index, first_command, second_command);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
