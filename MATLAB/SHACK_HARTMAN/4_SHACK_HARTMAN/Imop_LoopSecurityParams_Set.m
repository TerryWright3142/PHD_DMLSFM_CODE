function err_message = Imop_LoopSecurityParams_Set(security_params, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv)

% IMOP_LOOPSECURITYPARAMS_SET set tolerances
% 
%    security_params           Pointer to Closed Loop security params object adress.
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
% 

if nargin ~= 5
	error('The "Imop_LoopSecurityParams_Set" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_LoopSecurityParams_Set', err_message, security_params, max_saturated_act_count, max_camera_fill_pct, max_pupil_size_variation, max_dwf_pv);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
