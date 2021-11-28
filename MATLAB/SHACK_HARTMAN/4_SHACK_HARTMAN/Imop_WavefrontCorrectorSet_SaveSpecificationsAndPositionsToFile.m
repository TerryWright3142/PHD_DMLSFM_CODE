function err_message = Imop_WavefrontCorrectorSet_SaveSpecificationsAndPositionsToFile(wavefrontcorrector_set, position, pmc_file_path)

% IMOP_WAVEFRONTCORRECTORSET_SAVESPECIFICATIONSANDPOSITIONSTOFILE Not available
% Create pmc file with current wavefront corrector specifications and forced positions.
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    position                Positions values.
%                            
%    pmc_file_path           Positions file path.
%                            
%    err_message             Error message, empty if no error occured.
%                            
% 

if nargin ~= 3
	error('The "Imop_WavefrontCorrectorSet_SaveSpecificationsAndPositionsToFile" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, position, pmc_file_path] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_SaveSpecificationsAndPositionsToFile', err_message, wavefrontcorrector_set, position, pmc_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
