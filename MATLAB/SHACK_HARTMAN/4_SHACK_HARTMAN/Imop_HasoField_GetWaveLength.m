function [err_message, wavelength] = Imop_HasoField_GetWaveLength(HasoField)

% IMOP_HASOFIELD_GETWAVELENGTH Get the wavelength of the source.
% 
%    HasoField    HasoField object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    wavelength   Wavelength of the source (nm).
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoField_GetWaveLength" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
wavelength = 0;

[err_nb, err_message, wavelength] = calllib('WaveKitRuntime', 'Imop_HasoField_GetWaveLength', err_message, HasoField, wavelength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
