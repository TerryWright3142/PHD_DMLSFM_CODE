function err_message = Imop_WavefrontCorrector_CheckActuatorAbsolutePosition(corrector, actuator_index, position)

% IMOP_WAVEFRONTCORRECTOR_CHECKACTUATORABSOLUTEPOSITION Assert if requested absolute position satisfy current preferences.
%    If actuator is invalid, no error is thrown, since
%    position will be ignored by the Wavefront corrector.
% 
%    corrector       WavefrontCorrector object adress.
%                    
%    actuator_index  Index of the actuator.
%                    
%    position        Requested absolutes positions.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 3
	error('The "Imop_WavefrontCorrector_CheckActuatorAbsolutePosition" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_CheckActuatorAbsolutePosition', err_message, corrector, actuator_index, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
