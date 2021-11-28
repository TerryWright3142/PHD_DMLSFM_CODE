function err_message = Imop_HasoSlopes_SetWaveLength(HasoSlopes, wavelength)

% IMOP_HASOSLOPES_SETWAVELENGTH HasoSlopes wavelength setter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    wavelength   Wavelenght value.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_SetWaveLength" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_SetWaveLength', err_message, HasoSlopes, wavelength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
