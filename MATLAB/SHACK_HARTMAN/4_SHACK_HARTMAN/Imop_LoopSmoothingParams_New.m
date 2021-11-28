function [err_message, smoothing_params] = Imop_LoopSmoothingParams_New(low_gain_factor, high_gain_factor, low_amplitude, high_amplitude)

% IMOP_LOOPSMOOTHINGPARAMS_NEW loop smoothing parameters constructor
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
%    smoothing_params  Pointer to Closed Loop smoothing params object adress.
%                      
% 

if nargin ~= 4
	error('The "Imop_LoopSmoothingParams_New" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
smoothing_params = 0;

[err_nb, err_message, smoothing_params] = calllib('WaveKitRuntime', 'Imop_LoopSmoothingParams_New', err_message, low_gain_factor, high_gain_factor, low_amplitude, high_amplitude, smoothing_params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
