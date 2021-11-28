function [err_message, wavefrontcorrector_set] = Imop_WavefrontCorrectorSet_NewFromConfigFile(config_file_path)

% IMOP_WAVEFRONTCORRECTORSET_NEWFROMCONFIGFILE WavefrontCorrectorSet constructor
% 
%    config_file_path        Absolute path to Haso or Camera configuration file.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    wavefrontcorrector_set  Pointer to WavefrontCorrectorSet object adress.
%                            
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrectorSet_NewFromConfigFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
wavefrontcorrector_set = 0;

[err_nb, err_message, wavefrontcorrector_set, config_file_path] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_NewFromConfigFile', err_message, wavefrontcorrector_set, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
