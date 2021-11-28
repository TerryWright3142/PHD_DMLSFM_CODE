function err_message = Imop_WavefrontCorrector_AssertEqualPreferences(corrector, sleep_after_movement, min, max, validity, fixed_values)

% IMOP_WAVEFRONTCORRECTOR_ASSERTEQUALPREFERENCES Assert requested preferences are equal to current preferences
% 
%    corrector             WavefrontCorrector object adress.
%                          
%    sleep_after_movement  WavefrontCorrector preferences : Time to stabilization (ms).
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
% 

if nargin ~= 6
	error('The "Imop_WavefrontCorrector_AssertEqualPreferences" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, min, max, validity, fixed_values] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_AssertEqualPreferences', err_message, corrector, sleep_after_movement, min, max, validity, fixed_values);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
