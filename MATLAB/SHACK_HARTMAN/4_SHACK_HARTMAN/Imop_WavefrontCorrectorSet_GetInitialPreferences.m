function [err_message, max, min, validity, fixed_values, init_positions] = Imop_WavefrontCorrectorSet_GetInitialPreferences(wavefrontcorrector_set, max, min, validity, fixed_values, init_positions)

% IMOP_WAVEFRONTCORRECTORSET_GETINITIALPREFERENCES WavefrontCorrector constraints getter.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    max                     WavefrontCorrector preferences : highest command value. See cWavefrontCorrector.
%                            
%    min                     WavefrontCorrector preferences : lowest command value. See cWavefrontCorrector.
%                            
%    validity                WavefrontCorrector preferences : status. See cWavefrontCorrector.
%                            
%    fixed_values            WavefrontCorrector preferences : fixed positions. See cWavefrontCorrector.
%                            
%    init_positions          WavefrontCorrector preferences : init positions in init_from_config case. See cWavefrontCorrector.
%                            
%    err_message             Error message, empty if no error occured.
%                            
% 

if nargin ~= 6
	error('The "Imop_WavefrontCorrectorSet_GetInitialPreferences" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, max, min, validity, fixed_values, init_positions] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetInitialPreferences', err_message, wavefrontcorrector_set, max, min, validity, fixed_values, init_positions);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
