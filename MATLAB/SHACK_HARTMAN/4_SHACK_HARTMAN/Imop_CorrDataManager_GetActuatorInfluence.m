function [err_message, influence_slopes] = Imop_CorrDataManager_GetActuatorInfluence(corrdata_manager, actuator_index, use_actuator_pupil, influence_slopes)

% IMOP_CORRDATAMANAGER_GETACTUATORINFLUENCE Get actuator influence as HasoSlopes
% The influence pupil may be the pupil where actuator influence has been computed or the greatest common pupil of all the actuators
%    (CorrDataManager greatest common pupil).
%    Returns 0 HasoSlopes if actuator in not valid.
%    corrdata_manager    CorrDataManager object adress.
%                        
%    actuator_index      Actuator index.
%                        
%    use_actuator_pupil  If true, influence pupil will be the actuator's one, else it will be the corrdata_manager one.
%                        
%    influence_slopes    HasoSlopes object adress, representing the actuator influence.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 4
	error('The "Imop_CorrDataManager_GetActuatorInfluence" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetActuatorInfluence', err_message, corrdata_manager, actuator_index, use_actuator_pupil, influence_slopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
