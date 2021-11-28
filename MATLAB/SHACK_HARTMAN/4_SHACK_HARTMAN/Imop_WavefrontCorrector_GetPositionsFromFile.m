function err_message = Imop_WavefrontCorrector_GetPositionsFromFile(file_path)

% IMOP_WAVEFRONTCORRECTOR_GETPOSITIONSFROMFILE Get Wavefront corrector positions from positions file.
% 
%    file_path    Positions file path.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    position     Positions values.
%                 
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrector_GetPositionsFromFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, file_path, position] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_GetPositionsFromFile', err_message, file_path, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
