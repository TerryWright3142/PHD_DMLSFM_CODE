function [err_message, is_ok_saturated_act_count, is_ok_camera_fill_pct, is_ok_pupil_size_variation, is_ok_dwf_pv] = Imop_LoopSecurity_Check(security_activation, security_params, camera_fill_percentage, corrdata_manager, delta_slopes, current_corrector_positions, delta_commands)

% IMOP_LOOPSECURITY_CHECK Perform security checks required by security_activation using security_params values.
% 
%    security_activation          Pointer to Closed Loop activation params object adress.
%                                 
%    security_params              Pointer to Closed Loop security params object adress.
%                                 
%    camera_fill_percentage       Saturation percentage on camera signal
%                                 
%    corrdata_manager             Pointer to CorrDataManager object adress.
%                                 
%    delta_slopes                 Pointer to the HasoSlopes object containing the current AO residual slopes.
%                                 
%    current_corrector_positions  Pointer to the HasoSlopes object containing the current AO residual slopes.
%                                 
%    delta_commands               Array containing the actuators positions.
%                                 
%    err_message                  Error message, empty if no error occured.
%                                 
%    is_ok_saturated_act_count    Result of  actuators saturation check
%                                 
%    is_ok_camera_fill_pct        Result of saturation percentage on camera signal check
%                                 
%    is_ok_pupil_size_variation   Result of pupil size variation check
%                                 
%    is_ok_dwf_pv                 Result of residual wavefront peak-to-valley check
%                                 
% 

if nargin ~= 7
	error('The "Imop_LoopSecurity_Check" function requires 7 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, current_corrector_positions, delta_commands, is_ok_saturated_act_count, is_ok_camera_fill_pct, is_ok_pupil_size_variation, is_ok_dwf_pv] = calllib('WaveKitRuntime', 'Imop_LoopSecurity_Check', err_message, security_activation, security_params, camera_fill_percentage, corrdata_manager, delta_slopes, current_corrector_positions, delta_commands, is_ok_saturated_act_count, is_ok_camera_fill_pct, is_ok_pupil_size_variation, is_ok_dwf_pv);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
