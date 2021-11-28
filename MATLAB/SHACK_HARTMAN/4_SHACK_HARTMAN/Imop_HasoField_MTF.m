function [err_message, SurfaceMTF] = Imop_HasoField_MTF(surface_with_pupil_psf, config_file_path, SurfaceMTF)

% IMOP_HASOFIELD_MTF Modulation transfer function from point spread function surface
% 
%    surface_with_pupil_psf  PSF stored as Surface.
%                            
%    config_file_path        Absolute path to the Haso configuration file.
%                            
%    SurfaceMTF              MTF stored as Surface - Surface step in cycles/mm.
%                            
%    err_message             Error message, empty if no error occured.
%                            
% 

if nargin ~= 3
	error('The "Imop_HasoField_MTF" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, config_file_path] = calllib('WaveKitRuntime', 'Imop_HasoField_MTF', err_message, surface_with_pupil_psf, config_file_path, SurfaceMTF);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
