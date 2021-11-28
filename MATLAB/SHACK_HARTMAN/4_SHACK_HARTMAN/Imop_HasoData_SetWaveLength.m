function err_message = Imop_HasoData_SetWaveLength(HasoData, wavelength)

% IMOP_HASODATA_SETWAVELENGTH Set source wavelength.
% 
%    HasoData     HasoData object adress.
%                 
%    wavelength   Source wavelength (nm).
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoData_SetWaveLength" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_SetWaveLength', err_message, HasoData, wavelength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
