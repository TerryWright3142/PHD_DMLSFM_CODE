function [err_message, actuators_count] = Imop_WavefrontCorrectorSet_GetActuatorsCount(wavefrontcorrector_set)

% IMOP_WAVEFRONTCORRECTORSET_GETACTUATORSCOUNT WavefrontCorrector actuators count getter.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    actuators_count         Wavefront corrector actuators count.
%                            
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrectorSet_GetActuatorsCount" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
actuators_count = 0;

[err_nb, err_message, actuators_count] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetActuatorsCount', err_message, wavefrontcorrector_set, actuators_count);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
