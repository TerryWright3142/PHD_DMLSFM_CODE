function [err_message, factor] = Imop_LoopSmoothingParams_ComputeGainFactor(smoothing_params, amplitude)

% IMOP_LOOPSMOOTHINGPARAMS_COMPUTEGAINFACTOR Compute value of smoothing gain as a decreasing function of delta command amplitude
% This function is called in the Imop_CorrDataManager_ComputeClosedLoopIteration function,
%    where the applied_loop_gain is computed as the product of the computed factor and the specified_loop_gain.
%    smoothing_params  Closed Loop smoothing params object adress.
%                      
%    amplitude         delta command amplitude
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    factor            multiplicative factor to apply for final smoothing gain computation
%                      
% 

if nargin ~= 2
	error('The "Imop_LoopSmoothingParams_ComputeGainFactor" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
factor = 0;

[err_nb, err_message, factor] = calllib('WaveKitRuntime', 'Imop_LoopSmoothingParams_ComputeGainFactor', err_message, smoothing_params, amplitude, factor);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
