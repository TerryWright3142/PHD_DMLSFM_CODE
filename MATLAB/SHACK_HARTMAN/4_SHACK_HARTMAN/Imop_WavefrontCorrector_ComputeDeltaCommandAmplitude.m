function [err_message, delta_command_amplitude] = Imop_WavefrontCorrector_ComputeDeltaCommandAmplitude(corrector, delta_commands)

% IMOP_WAVEFRONTCORRECTOR_COMPUTEDELTACOMMANDAMPLITUDE Compute a relative move amplitude as the max displacement percentage among all the valid actuators.
%    For one actuator : Displacement percentage = displacement / (max - min) * 100
% 
%    corrector                WavefrontCorrector object adress.
%                             
%    delta_commands           Delta command to analyze.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    delta_command_amplitude  Computed delta command amplitude.
%                             
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_ComputeDeltaCommandAmplitude" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
delta_command_amplitude = 0;

[err_nb, err_message, delta_commands, delta_command_amplitude] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_ComputeDeltaCommandAmplitude', err_message, corrector, delta_commands, delta_command_amplitude);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
