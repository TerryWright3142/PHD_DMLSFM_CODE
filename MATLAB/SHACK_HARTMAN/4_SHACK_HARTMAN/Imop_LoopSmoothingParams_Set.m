function err_message = Imop_LoopSmoothingParams_Set(smoothing_params, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude)

% IMOP_LOOPSMOOTHINGPARAMS_SET Set closed loop smoothing parameters
% 
%    smoothing_params  Closed Loop smoothing params object adress.
%                      
%    low_gain_factor   lowest value for gain factor
%                      
%    high_gain_factor  highest value for gain factor
%                      
%    low_amplitude     lowest amplitude value before switching to linear behavior
%                      
%    high_amplitude    highest amplitude value where linear behavior stops
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 5
	error('The "Imop_LoopSmoothingParams_Set" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_LoopSmoothingParams_Set', err_message, smoothing_params, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
