function [err_message, size] = Imop_WavefrontCorrectorSet_GetSpecificFeaturesListSize(wavefrontcorrector_set)

% IMOP_WAVEFRONTCORRECTORSET_GETSPECIFICFEATURESLISTSIZE WavefrontCorrector features list size getter.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    size                    Features list size.
%                            
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrectorSet_GetSpecificFeaturesListSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = 0;

[err_nb, err_message, size] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetSpecificFeaturesListSize', err_message, wavefrontcorrector_set, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
