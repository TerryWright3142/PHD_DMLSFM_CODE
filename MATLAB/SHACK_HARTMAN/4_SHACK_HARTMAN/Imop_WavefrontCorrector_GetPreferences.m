function [err_message, sleep_after_movement, min, max, validity, fixed_values] = Imop_WavefrontCorrector_GetPreferences(corrector, min, max, validity, fixed_values)

% IMOP_WAVEFRONTCORRECTOR_GETPREFERENCES Get current preferences
% 
%    corrector             WavefrontCorrector object adress.
%                          
%    min                   WavefrontCorrector preferences : lowest command value.
%                          
%    max                   WavefrontCorrector preferences : highest command value.
%                          
%    validity              WavefrontCorrector preferences : status.
%                          
%    fixed_values          WavefrontCorrector preferences : fixed positions.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    sleep_after_movement  WavefrontCorrector preferences : Time to stabilization (ms).
%                          
% 

if nargin ~= 5
	error('The "Imop_WavefrontCorrector_GetPreferences" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
sleep_after_movement = 0;

[err_nb, err_message, sleep_after_movement, min, max, validity, fixed_values] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetPreferences', err_message, corrector, sleep_after_movement, min, max, validity, fixed_values);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
