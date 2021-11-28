function err_message = Imop_WavefrontCorrector_SaveCurrentPositionsToFile(corrector, pmc_file_path)

% IMOP_WAVEFRONTCORRECTOR_SAVECURRENTPOSITIONSTOFILE Save current Wavefront corrector positions to positions file.
% 
%    corrector      WavefrontCorrector object adress.
%                   
%    pmc_file_path  Positions file path.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_SaveCurrentPositionsToFile" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, pmc_file_path] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_SaveCurrentPositionsToFile', err_message, corrector, pmc_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
