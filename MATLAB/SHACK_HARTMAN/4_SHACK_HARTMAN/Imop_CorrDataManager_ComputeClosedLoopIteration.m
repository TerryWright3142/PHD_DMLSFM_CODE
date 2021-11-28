function [err_message, delta_command, applied_loop_gain] = Imop_CorrDataManager_ComputeClosedLoopIteration(corrdata_manager, delta_slopes, delta_command, do_tilt_check, smoothing_params, specified_loop_gain)

% IMOP_CORRDATAMANAGER_COMPUTECLOSEDLOOPITERATION Compute the commands associated to one closed-loop iteration targeting delta_slopes.
% This function is quite similar to Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes.
%    The difference is that the computed delta command takes the provided smoothing parameters
%    and specified gain into account.
%    The real loop gain applied on computed delta command is returned via the applied_loop_gain.
%    corrdata_manager     CorrDataManager object adress.
%                         
%    delta_slopes         Array of target slopes deltas (stored as HasoSlopes).
%                         
%    do_tilt_check        Indicates if the computed commands deltas must be adapted to avoid huge tilts.
%                         
%    smoothing_params     Closed Loop smoothing params object adress.
%                         
%    specified_loop_gain  User specified loop smoothing gain
%                         
%    delta_command        Array of size actuators count, containing the commands deltas (relatives variations to apply from actuators initial positions).
%                         
%    err_message          Error message, empty if no error occured.
%                         
%    applied_loop_gain    Loop smoothing gain really applied
%                         
% 

if nargin ~= 6
	error('The "Imop_CorrDataManager_ComputeClosedLoopIteration" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
applied_loop_gain = 0;

[err_nb, err_message, delta_command, applied_loop_gain] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ComputeClosedLoopIteration', err_message, corrdata_manager, delta_slopes, delta_command, do_tilt_check, smoothing_params, specified_loop_gain, applied_loop_gain);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
