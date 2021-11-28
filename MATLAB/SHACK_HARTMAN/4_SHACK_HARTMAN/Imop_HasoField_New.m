function [err_message, HasoField, wavelength] = Imop_HasoField_New(haso_config_file_path, HasoSlopes, Phase, radius_of_curvature, oversampling_level)

% IMOP_HASOFIELD_NEW HasoField constructor from HasoSlopes and phase
% HasoSlopes provides slopes pupil, and HasoSlopes provides a pupil which is expected
%    to be equal to slopes pupil or to the greatest common
%    pupil between slopes pupil and a projection pupil used for HasoSlopes computation.
%    This implies that pupil of HasoSlopes must be included in pupil of
%    HasoSlopes. After checking this is the case, function uses the pupil
%    of HasoSlopes for resulting HasoSlopes.
%    It is possible to oversample the resulting field: each increment of oversampling_level doubles the field's size.
%    haso_config_file_path  Absolute path to Haso configuration file.
%                           
%    HasoSlopes             HasoSlopes object adress.
%                           
%    Phase                  phase object adress.
%                           
%    radius_of_curvature    Radius of curvature (mm).
%                           
%    oversampling_level     Increment of oversampling level.
%                           
%    err_message            Error message, empty if no error occured.
%                           
%    HasoField              Pointer to HasoField object adress.
%                           
%    wavelength             Wavelenght of the source used to compute the HasoSlopes (nm).
%                           
% 

if nargin ~= 5
	error('The "Imop_HasoField_New" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoField = 0;
wavelength = 0;

[err_nb, err_message, HasoField, haso_config_file_path, wavelength] = calllib('WaveKitRuntime', 'Imop_HasoField_New', err_message, HasoField, haso_config_file_path, HasoSlopes, Phase, radius_of_curvature, wavelength, oversampling_level);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
