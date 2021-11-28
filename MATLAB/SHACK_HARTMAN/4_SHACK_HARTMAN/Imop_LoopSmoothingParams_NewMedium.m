function [err_message, smoothing_params] = Imop_LoopSmoothingParams_NewMedium()

% IMOP_LOOPSMOOTHINGPARAMS_NEWMEDIUM loop smoothing parameters constructor : Smooth a little
% 
%    err_message       Error message, empty if no error occured.
%                      
%    smoothing_params  Pointer to Closed Loop smoothing params object adress.
%                      
% 

if nargin ~= 0
	error('The "Imop_LoopSmoothingParams_NewMedium" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
smoothing_params = 0;

[err_nb, err_message, smoothing_params] = calllib('WaveKitRuntime', 'Imop_LoopSmoothingParams_NewMedium', err_message, smoothing_params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
