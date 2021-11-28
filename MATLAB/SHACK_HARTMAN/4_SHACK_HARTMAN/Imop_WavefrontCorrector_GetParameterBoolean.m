function [err_message, value] = Imop_WavefrontCorrector_GetParameterBoolean(corrector, parameter_name)

% IMOP_WAVEFRONTCORRECTOR_GETPARAMETERBOOLEAN Wavefront corrector parameter getter for parameter of type E_TYPE_BOOL.
% 
%    corrector       WavefrontCorrector object adress.
%                    
%    parameter_name  Name of the parameter.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    value           Value of the parameter.
%                    
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_GetParameterBoolean" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
value = 0;

[err_nb, err_message, parameter_name, value] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetParameterBoolean', err_message, corrector, parameter_name, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
