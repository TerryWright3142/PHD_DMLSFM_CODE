function [err_message, saturated_act_count] = Imop_CorrDataManager_CheckRelativePositionsSaturation(corrdata_manager, current_position, delta_commands)

% IMOP_CORRDATAMANAGER_CHECKRELATIVEPOSITIONSSATURATION Count the number of actuators which will be saturated (reaching min or max of their positions) if relative command is applied
% 
%    corrdata_manager     WavefrontCorrector object adress.
%                         
%    current_position     Array of current wavefront corrector positions.
%                         
%    delta_commands       Array of delta commands.
%                         
%    err_message          Error message, empty if no error occured.
%                         
%    saturated_act_count  Count of actuators which will be at min or max of their positions if command is applied.
%                         
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_CheckRelativePositionsSaturation" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
saturated_act_count = 0;

[err_nb, err_message, current_position, delta_commands, saturated_act_count] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_CheckRelativePositionsSaturation', err_message, corrdata_manager, current_position, delta_commands, saturated_act_count);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
