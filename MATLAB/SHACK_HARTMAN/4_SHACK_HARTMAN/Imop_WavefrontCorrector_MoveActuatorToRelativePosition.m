function err_message = Imop_WavefrontCorrector_MoveActuatorToRelativePosition(corrector, actuator_index, position)

% IMOP_WAVEFRONTCORRECTOR_MOVEACTUATORTORELATIVEPOSITION Move to requested relative position, clip according to current preferences.
% 
%    corrector       WavefrontCorrector object adress.
%                    
%    actuator_index  Index of the actuator.
%                    
%    position        Requested relatives positions.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 3
	error('The "Imop_WavefrontCorrector_MoveActuatorToRelativePosition" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_MoveActuatorToRelativePosition', err_message, corrector, actuator_index, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
