function [err_message, feature_name] = Imop_WavefrontCorrectorSet_GetSpecificFeatureName(wavefrontcorrector_set, index)

% IMOP_WAVEFRONTCORRECTORSET_GETSPECIFICFEATURENAME WavefrontCorrector features name getter given its position in the parameters list.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    index                   Feature index.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    feature_name            Feature name.
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetSpecificFeatureName" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
feature_name = char(ones(256,1,'int8'));

[err_nb, err_message, feature_name] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetSpecificFeatureName', err_message, wavefrontcorrector_set, index, feature_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
