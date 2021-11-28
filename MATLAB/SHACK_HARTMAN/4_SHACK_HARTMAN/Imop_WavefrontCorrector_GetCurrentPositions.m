function [err_message, position] = Imop_WavefrontCorrector_GetCurrentPositions(corrector, position)

% IMOP_WAVEFRONTCORRECTOR_GETCURRENTPOSITIONS Get current actuators positions
% 
%    corrector    WavefrontCorrector object adress.
%                 
%    position     Array containing the actuators positions.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_GetCurrentPositions" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, position] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetCurrentPositions', err_message, corrector, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
