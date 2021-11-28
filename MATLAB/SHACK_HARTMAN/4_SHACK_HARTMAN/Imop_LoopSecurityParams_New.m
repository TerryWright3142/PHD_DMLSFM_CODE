function [err_message, security_params] = Imop_LoopSecurityParams_New(max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv)

% IMOP_LOOPSECURITYPARAMS_NEW Manual construction
% 
%    max_saturated_act_count   Maximum tolerated count of saturated actuators
%                              
%    max_camera_fill_pct       Maximum tolerated saturation percentage on camera signal
%                              
%    max_pupil_size_variation  Maximum tolerated variation of the pupil size, relatively to the command matrix pupil size
%                              
%    max_dwf_pv                Maximum tolerated delta wavefront peak-to-valley
%                              
%    err_message               Error message, empty if no error occured.
%                              
%    security_params           Pointer to Closed Loop security params object adress.
%                              
% 

if nargin ~= 4
	error('The "Imop_LoopSecurityParams_New" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
security_params = 0;

[err_nb, err_message, security_params] = calllib('WaveKitRuntime', 'Imop_LoopSecurityParams_New', err_message, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv, security_params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
