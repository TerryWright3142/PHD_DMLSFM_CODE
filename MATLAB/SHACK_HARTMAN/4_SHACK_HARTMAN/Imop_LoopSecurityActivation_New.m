function [err_message, security_activation] = Imop_LoopSecurityActivation_New(do_check_saturated_act_count, do_check_camera_fill_pct, do_check_pupil_size_variation, do_check_dwf_pv)

% IMOP_LOOPSECURITYACTIVATION_NEW Manual construction
% 
%    do_check_saturated_act_count   Activates the requested actuators positions check, test will return false if too many acturators reach their boundaries
%                                   
%    do_check_camera_fill_pct       Activates the camera saturation level check
%                                   
%    do_check_pupil_size_variation  Activates the pupil size variation check, test will return false if pupil is too different from the interaction matrix pupil
%                                   
%    do_check_dwf_pv                Activates the delta wavefront peak-to-valley check
%                                   
%    err_message                    Error message, empty if no error occured.
%                                   
%    security_activation            Pointer to Closed Loop security activation object adress.
%                                   
% 

if nargin ~= 4
	error('The "Imop_LoopSecurityActivation_New" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
security_activation = 0;

[err_nb, err_message, security_activation] = calllib('WaveKitRuntime', 'Imop_LoopSecurityActivation_New', err_message, do_check_saturated_act_count, do_check_camera_fill_pct, do_check_pupil_size_variation, do_check_dwf_pv, security_activation);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
