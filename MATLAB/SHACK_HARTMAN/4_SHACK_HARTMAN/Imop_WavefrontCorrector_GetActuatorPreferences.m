function err_message = Imop_WavefrontCorrector_GetActuatorPreferences(corrector, actuator_index, min, max, validity, fixed_values)

% IMOP_WAVEFRONTCORRECTOR_GETACTUATORPREFERENCES Get preferences of actuator
% 
%    corrector       WavefrontCorrector object adress.
%                    
%    actuator_index  Index of the actuator.
%                    
%    min             WavefrontCorrector actuator preferences : lowest command value.
%                    
%    max             WavefrontCorrector actuator preferences : highest command value.
%                    
%    validity        WavefrontCorrector actuator preferences : status.
%                    
%    fixed_values    WavefrontCorrector actuator preferences : fixed positions.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 6
	error('The "Imop_WavefrontCorrector_GetActuatorPreferences" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, min, max, validity, fixed_values] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetActuatorPreferences', err_message, corrector, actuator_index, min, max, validity, fixed_values);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
