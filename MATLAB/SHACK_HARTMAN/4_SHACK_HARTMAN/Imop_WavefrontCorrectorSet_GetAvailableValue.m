function [err_message, value] = Imop_WavefrontCorrectorSet_GetAvailableValue(wavefrontcorrector_set, parameter_name, index)

% IMOP_WAVEFRONTCORRECTORSET_GETAVAILABLEVALUE If parameter is a string to be selected among a finite set of strings,
%    extract the possible value located at the /p index position from this set.
%    See Imop_WavefrontCorrectorSet_GetParameterOption.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    parameter_name          Parameter name (must be the name of a parameter of type strings list).
%                            
%    index                   Sub-parameter index.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    value                   Value at index index.
%                            
% 

if nargin ~= 3
	error('The "Imop_WavefrontCorrectorSet_GetAvailableValue" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
value = char(ones(256,1,'int8'));

[err_nb, err_message, parameter_name, value] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetAvailableValue', err_message, wavefrontcorrector_set, parameter_name, index, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
