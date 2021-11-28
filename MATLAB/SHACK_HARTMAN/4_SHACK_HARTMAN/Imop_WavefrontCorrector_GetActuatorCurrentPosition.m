function [err_message, position] = Imop_WavefrontCorrector_GetActuatorCurrentPosition(corrector, actuator_index, position)

% IMOP_WAVEFRONTCORRECTOR_GETACTUATORCURRENTPOSITION Get current position of actuator
% 
%    corrector       WavefrontCorrector object adress.
%                    
%    actuator_index  Index of the actuator.
%                    
%    position        Position of the actuator.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 3
	error('The "Imop_WavefrontCorrector_GetActuatorCurrentPosition" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, position] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetActuatorCurrentPosition', err_message, corrector, actuator_index, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
