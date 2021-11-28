function [err_message, parameter_name] = Imop_WavefrontCorrectorSet_GetParameterName(wavefrontcorrector_set, index)

% IMOP_WAVEFRONTCORRECTORSET_GETPARAMETERNAME WavefrontCorrector parameter name getter given its position in the parameters list.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    index                   Parameter index.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    parameter_name          Parameter name.
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetParameterName" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
parameter_name = char(ones(256,1,'int8'));

[err_nb, err_message, parameter_name] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetParameterName', err_message, wavefrontcorrector_set, index, parameter_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
