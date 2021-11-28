function err_message = Imop_WavefrontCorrector_SetActuatorPreferences(corrector, actuator_index, min, max, validity, fixed_value)

% IMOP_WAVEFRONTCORRECTOR_SETACTUATORPREFERENCES Set preferences of actuator
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
%    fixed_value     WavefrontCorrector actuator preferences : fixed positions.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 6
	error('The "Imop_WavefrontCorrector_SetActuatorPreferences" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_SetActuatorPreferences', err_message, corrector, actuator_index, min, max, validity, fixed_value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
