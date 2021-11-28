function err_message = Imop_WavefrontCorrector_CallSpecificFeature(corrector, feature_name)

% IMOP_WAVEFRONTCORRECTOR_CALLSPECIFICFEATURE Perform a wavefront corrector action regarding its name.
% 
%    corrector     WavefrontCorrector object adress.
%                  
%    feature_name  Name of the action.
%                  
%    err_message   Error message, empty if no error occured.
%                  
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_CallSpecificFeature" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, feature_name] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_CallSpecificFeature', err_message, corrector, feature_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
