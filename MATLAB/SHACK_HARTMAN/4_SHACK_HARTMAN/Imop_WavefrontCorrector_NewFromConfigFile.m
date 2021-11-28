function [err_message, corrector] = Imop_WavefrontCorrector_NewFromConfigFile(config_file_path)

% IMOP_WAVEFRONTCORRECTOR_NEWFROMCONFIGFILE WavefrontCorrector constructor
% 
%    config_file_path  Absolute path to Wavefront corrector configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    corrector         Pointer to WavefrontCorrector object adress.
%                      
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrector_NewFromConfigFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
corrector = 0;

[err_nb, err_message, corrector, config_file_path] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_NewFromConfigFile', err_message, corrector, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
