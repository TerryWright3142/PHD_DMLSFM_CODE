function [err_message, SurfacePSF] = Imop_HasoField_PSF(HasoField, null_phase, flat_intensity, defocus, config_file_path, SurfacePSF)

% IMOP_HASOFIELD_PSF Point spread function
% This function computes point spread function from a HasoField. The
%    function allows to choose the defocus which is zero by default. It also
%    provides options to use null phase instead of measured phase, and flat
%    intensity instead of measured intensity. When using a null phase, phase
%    contained in input HasoField is not used. When using a flat intensity,
%    intensity contained in input HasoField is used anyway, as well as pupil, to
%    compute average intensity.
%    HasoField         HasoField object adress.
%                      
%    null_phase        Phase is null.
%                      
%    flat_intensity    Intensity surface is flat.
%                      
%    defocus           Defocus parameter(mm).
%                      
%    config_file_path  Absolute path to the Haso configuration file.
%                      
%    SurfacePSF        PSF stored as Surface - Surface step in um.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 6
	error('The "Imop_HasoField_PSF" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, config_file_path] = calllib('WaveKitRuntime', 'Imop_HasoField_PSF', err_message, HasoField, null_phase, flat_intensity, defocus, config_file_path, SurfacePSF);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
