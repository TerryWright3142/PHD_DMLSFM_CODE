function [err_message, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude] = Imop_LoopSmoothingParams_Get(smoothing_params)

% IMOP_LOOPSMOOTHINGPARAMS_GET Get closed loop smoothing parameters
% 
%    smoothing_params  Closed Loop smoothing params object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    low_gain_factor   lowest value for gain factor
%                      
%    high_gain_factor  highest value for gain factor
%                      
%    low_amplitude     lowest amplitude value before switching to linear behavior
%                      
%    high_amplitude    highest amplitude value where linear behavior stops
%                      
% 

if nargin ~= 1
	error('The "Imop_LoopSmoothingParams_Get" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
low_gain_factor = 0;
high_gain_factor = 0;
low_amplitude = 0;
high_amplitude = 0;

[err_nb, err_message, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude] = calllib('WaveKitRuntime', 'Imop_LoopSmoothingParams_Get', err_message, smoothing_params, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
