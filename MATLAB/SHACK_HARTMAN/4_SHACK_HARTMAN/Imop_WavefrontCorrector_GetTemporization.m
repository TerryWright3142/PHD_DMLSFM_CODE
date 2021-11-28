function [err_message, sleep_after_movement] = Imop_WavefrontCorrector_GetTemporization(corrector)

% IMOP_WAVEFRONTCORRECTOR_GETTEMPORIZATION Get current WavefrontCorrector preference "Time to stabilization (ms)".
% 
%    corrector             WavefrontCorrector object adress.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    sleep_after_movement  WavefrontCorrector preferences : Time to stabilization (ms).
%                          
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrector_GetTemporization" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
sleep_after_movement = 0;

[err_nb, err_message, sleep_after_movement] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetTemporization', err_message, corrector, sleep_after_movement);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
