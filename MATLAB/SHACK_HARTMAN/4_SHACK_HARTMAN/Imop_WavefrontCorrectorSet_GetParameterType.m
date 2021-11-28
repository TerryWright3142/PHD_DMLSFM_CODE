function [err_message, type] = Imop_WavefrontCorrectorSet_GetParameterType(wavefrontcorrector_set, parameter_name)

% IMOP_WAVEFRONTCORRECTORSET_GETPARAMETERTYPE WavefrontCorrector parameter type getter given its name which should have been read with Imop_WavefrontCorrectorSet_GetParameterName.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    parameter_name          Parameter name.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    type                    Parameter type value, @see E_TYPES_T
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetParameterType" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
type = 0;

[err_nb, err_message, parameter_name, type] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetParameterType', err_message, wavefrontcorrector_set, parameter_name, type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
