function [err_message, waist_position_millimeter, waist_radius_millimeter, rayleigh_length_millimeter, divergence, msquared, tab_z_cote_mm, tab_spot_size_mm, tab_psf, threshold, tab_max_energy] = Imop_HasoField_CompleteGaussianParam(config_file_path, HasoField, nb_planes, spot_type, degree, tab_z_cote_mm, tab_spot_size_mm, tab_psf, tab_max_energy)

% IMOP_HASOFIELD_COMPLETEGAUSSIANPARAM Complete gaussian parameters function
% This function computes gaussian parameters of a beam from a HasoField.
%    Input HasoField is used to compute values of the point spread function (PSF)
%    over different computation planes. The number of computation planes can be
%    set by user. The different computation planes constitute the computation
%    data, which can be got after processing. In a given computation plane, the
%    PSF forms a spot which can be approximated by a circle or a square whose size
%    plays a role for gaussian parameters determination. By default, the function
%    is configured to use circular spots, but it can be configured to use tilted
%    square spots. The square's tilt is defined by the angle it forms with an
%    horizontal axis. When the processor is configured to use circular spots, it
%    characterizes the circle by its radius. When the processor is configured to
%    use square spots, it characterizes the square by the half length of its side.
%    In both cases, this quantity is stored in attribute spot_size of
%    corresponding ComputationPlane instance.
%    config_file_path            Absolute path to the Haso configuration file.
%                                
%    HasoField                   HasoField object adress.
%                                
%    nb_planes                   Number of planes.
%                                
%    spot_type                   "square" or "circle" spot shape.
%                                
%    degree                      Angle of the square spot shape forms with an horizontal axis (degree).///<
%                                
%    tab_z_cote_mm               Array of z cote (mm) of the different planes.
%                                
%    tab_spot_size_mm            Array of spot size (mm) of the different planes.
%                                
%    tab_psf                     Array of computed psf - psf is a surface with step mm.
%                                
%    tab_max_energy              Array of max energy of the different planes.
%                                
%    err_message                 Error message, empty if no error occured.
%                                
%    waist_position_millimeter   Waist position (mm).
%                                
%    waist_radius_millimeter     Waist radius (mm).
%                                
%    rayleigh_length_millimeter  Rayleigh length (mm).
%                                
%    divergence                  Divergence of the beam (radians).
%                                
%    msquared                    m squared parameter.
%                                
%    threshold                   Check whether the entire beam of last processing could be got.
%                                
% 

if nargin ~= 9
	error('The "Imop_HasoField_CompleteGaussianParam" function requires 9 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
waist_position_millimeter = 0;
waist_radius_millimeter = 0;
rayleigh_length_millimeter = 0;
divergence = 0;
msquared = 0;
threshold = 0;

[err_nb, err_message, config_file_path, waist_position_millimeter, waist_radius_millimeter, rayleigh_length_millimeter, divergence, msquared, spot_type, tab_z_cote_mm, tab_spot_size_mm, tab_psf, threshold, tab_max_energy] = calllib('WaveKitRuntime', 'Imop_HasoField_CompleteGaussianParam', err_message, config_file_path, HasoField, nb_planes, waist_position_millimeter, waist_radius_millimeter, rayleigh_length_millimeter, divergence, msquared, spot_type, degree, tab_z_cote_mm, tab_spot_size_mm, tab_psf, threshold, tab_max_energy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
