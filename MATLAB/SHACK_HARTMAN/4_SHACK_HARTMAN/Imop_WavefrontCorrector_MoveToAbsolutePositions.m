function err_message = Imop_WavefrontCorrector_MoveToAbsolutePositions(corrector, position)

% IMOP_WAVEFRONTCORRECTOR_MOVETOABSOLUTEPOSITIONS Move to requested absolute positions, clip according to current preferences.
% 
%    corrector    WavefrontCorrector object adress.
%                 
%    position     Requested absolutes positions.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_MoveToAbsolutePositions" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, position] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_MoveToAbsolutePositions', err_message, corrector, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
