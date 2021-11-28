function err_message = Imop_WavefrontCorrector_CheckRelativePositions(corrector, position)

% IMOP_WAVEFRONTCORRECTOR_CHECKRELATIVEPOSITIONS Assert if requested relative positions satisfy current preferences.
%    If actuator condition is E_ACTUATOR_CONDITION_INVALID, no error is thrown, since
%    position will be ignored by the Wavefront corrector.
% 
%    corrector    WavefrontCorrector object adress.
%                 
%    position     Requested relatives positions.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_CheckRelativePositions" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, position] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_CheckRelativePositions', err_message, corrector, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
