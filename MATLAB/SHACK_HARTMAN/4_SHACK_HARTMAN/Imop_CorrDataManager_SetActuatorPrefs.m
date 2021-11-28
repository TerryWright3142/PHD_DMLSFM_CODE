function [err_message, new_data_needed] = Imop_CorrDataManager_SetActuatorPrefs(corrdata_manager, actuator_index, min, max, validity, fixed_value)

% IMOP_CORRDATAMANAGER_SETACTUATORPREFS Preferences setter for one wavefront corrector actuator.
% The new preferences have to be compliant with the Wavefront corrector specifications (read from configuration file).
%    If the new preferences are compliant with the one used for the last calibration process or the last loaded ones, the interaction matrix is recomputed,
%    else the interaction matrix is erased and a new calibration process (or loading from file or backup restoration) is needed.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    actuator_index    Index of the actuator.
%                      
%    min               WavefrontCorrector actuator preferences : lowest command value.
%                      
%    max               WavefrontCorrector actuator preferences : highest command value.
%                      
%    validity          WavefrontCorrector actuator preferences : status.
%                      
%    fixed_value       WavefrontCorrector actuator preferences : fixed positions.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    new_data_needed   if true, indicates that interaction matrix has been erased.
%                      
% 

if nargin ~= 6
	error('The "Imop_CorrDataManager_SetActuatorPrefs" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, new_data_needed] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_SetActuatorPrefs', err_message, corrdata_manager, actuator_index, min, max, validity, fixed_value, new_data_needed);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
