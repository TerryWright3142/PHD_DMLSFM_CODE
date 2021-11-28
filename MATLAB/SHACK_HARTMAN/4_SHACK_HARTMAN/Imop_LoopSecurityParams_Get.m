function [err_message, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv] = Imop_LoopSecurityParams_Get(security_params)

% IMOP_LOOPSECURITYPARAMS_GET get tolerances
% 
%    security_params           Pointer to Closed Loop security params object adress.
%                              
%    err_message               Error message, empty if no error occured.
%                              
%    max_saturated_act_count   Maximum tolerated count of saturated actuators
%                              
%    max_camera_fill_pct       Maximum tolerated saturation percentage on camera signal
%                              
%    max_pupil_size_variation  Maximum tolerated variation of the pupil size, relatively to the command matrix pupil size
%                              
%    max_dwf_pv                Maximum tolerated loop smoothing gain
%                              
% 

if nargin ~= 1
	error('The "Imop_LoopSecurityParams_Get" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
max_saturated_act_count = 0;
max_camera_fill_pct = 0;
max_pupil_size_variation = 0;
max_dwf_pv = 0;

[err_nb, err_message, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv] = calllib('WaveKitRuntime', 'Imop_LoopSecurityParams_Get', err_message, security_params, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
