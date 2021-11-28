function err_message = Imop_WavefrontCorrector_SetTemporization(corrector, sleep_after_movement)

% IMOP_WAVEFRONTCORRECTOR_SETTEMPORIZATION Set current WavefrontCorrector preference "Time to stabilization (ms)",
%    clip or ignore if specifications constraints are not fulfilled.
% 
%    corrector             WavefrontCorrector object adress.
%                          
%    sleep_after_movement  WavefrontCorrector preferences : Time to stabilization (ms).
%                          
%    err_message           Error message, empty if no error occured.
%                          
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_SetTemporization" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_SetTemporization', err_message, corrector, sleep_after_movement);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
