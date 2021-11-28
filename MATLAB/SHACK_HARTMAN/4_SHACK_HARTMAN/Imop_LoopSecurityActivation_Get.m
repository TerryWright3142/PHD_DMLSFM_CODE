function [err_message, do_check_saturated_act_count, do_check_camera_fill_pct, do_check_pupil_size_variation, do_check_dwf_pv] = Imop_LoopSecurityActivation_Get(security_activation)

% IMOP_LOOPSECURITYACTIVATION_GET get switches states
% 
%    security_activation            Pointer to Closed Loop activation params object adress.
%                                   
%    err_message                    Error message, empty if no error occured.
%                                   
%    do_check_saturated_act_count   Activates the requested actuators positions check, test will return false if too many acturators reach their boundaries
%                                   
%    do_check_camera_fill_pct       Activates the camera saturation level check
%                                   
%    do_check_pupil_size_variation  Activates the pupil size variation check, test will return false if pupil is too different from the interaction matrix pupil
%                                   
%    do_check_dwf_pv                Activates the delta wavefront peak-to-valley check
%                                   
% 

if nargin ~= 1
	error('The "Imop_LoopSecurityActivation_Get" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, do_check_saturated_act_count, do_check_camera_fill_pct, do_check_pupil_size_variation, do_check_dwf_pv] = calllib('WaveKitRuntime', 'Imop_LoopSecurityActivation_Get', err_message, security_activation, do_check_saturated_act_count, do_check_camera_fill_pct, do_check_pupil_size_variation, do_check_dwf_pv);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
