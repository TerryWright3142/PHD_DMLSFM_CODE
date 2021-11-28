function [err_message, min, max] = Imop_WavefrontCorrectorSet_GetParameterRealLimits(wavefrontcorrector_set, parameter_name)

% IMOP_WAVEFRONTCORRECTORSET_GETPARAMETERREALLIMITS WavefrontCorrectorSet parameter range getter for parameter of type float.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    parameter_name          Parameter name.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    min                     Minimum value accepted.
%                            
%    max                     Maximum value accepted.
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetParameterRealLimits" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
min = 0;
max = 0;

[err_nb, err_message, parameter_name, min, max] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetParameterRealLimits', err_message, wavefrontcorrector_set, parameter_name, min, max);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
