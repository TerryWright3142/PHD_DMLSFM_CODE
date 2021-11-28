function [err_message, size] = Imop_WavefrontCorrectorSet_GetAvailableValuesListSize(wavefrontcorrector_set, parameter_name)

% IMOP_WAVEFRONTCORRECTORSET_GETAVAILABLEVALUESLISTSIZE If parameter is a string to be selected among a finite set of strings, return the size of this set.
%    See Imop_WavefrontCorrectorSet_GetParameterOption.
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    parameter_name          Parameter name.
%                            
%    err_message             Error message, empty if no error occured.
%                            
%    size                    Size of the list (count of strings expected in that parameter).
%                            
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrectorSet_GetAvailableValuesListSize" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = 0;

[err_nb, err_message, parameter_name, size] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetAvailableValuesListSize', err_message, wavefrontcorrector_set, parameter_name, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
