function [err_message, flat_command] = Imop_WavefrontCorrectorSet_GetFlatMirrorPositions(wavefrontcorrector_set, flat_command)

% IMOP_WAVEFRONTCORRECTORSET_GETFLATMIRRORPOSITIONS WavefrontCorrector commands to flat mirror shape getter.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    flat_command            Array of commands to apply to have a flat wavefront corrector surface.
%                            
%    err_message             Error message, empty if no error occured.
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetFlatMirrorPositions" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, flat_command] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetFlatMirrorPositions', err_message, wavefrontcorrector_set, flat_command);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
