function [err_message, min, max, validity, fixed_value] = Imop_CorrDataManager_GetCorrectorInitPrefs(corrdata_manager, min, max, validity, fixed_value)

% IMOP_CORRDATAMANAGER_GETCORRECTORINITPREFS Wavefront corrector actuators preferences getter.
% 
%    corrdata_manager  CorrDataManager object adress
%                      
%    min               WavefrontCorrector preferences : lowest command value.
%                      
%    max               WavefrontCorrector preferences : highest command value.
%                      
%    validity          WavefrontCorrector preferences : status.
%                      
%    fixed_value       WavefrontCorrector preferences : fixed positions.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 5
	error('The "Imop_CorrDataManager_GetCorrectorInitPrefs" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, min, max, validity, fixed_value] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetCorrectorInitPrefs', err_message, corrdata_manager, min, max, validity, fixed_value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
