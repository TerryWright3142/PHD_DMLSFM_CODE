function [err_message, strehl_ratio] = Imop_HasoField_Strehl(HasoField, config_file_path, flat_experimental_intensity, flat_theoretical_intensity, through_focus, oversample, defocus)

% IMOP_HASOFIELD_STREHL Strehl ratio from HasoField function
% This function computes Strehl ratio from a HasoField. Input HasoField is
%    used to compute experimental and theoretical point spread functions (PSF).
%    The function allows to choose the defocus. It also
%    provides options to use flat intensity instead of measured intensity for
%    computation of experimental or theoretical PSF. Another option is available
%    to compute Strehl ratio through focus, in which case theoretical PSF is
%    computed in the same place as experimental PSF rather than at focal point.
%    There is also an option to oversample PSF surfaces before ratio computation.
%    HasoField                    HasoField object adress.
%                                 
%    config_file_path             Absolute path to the Haso configuration file.
%                                 
%    flat_experimental_intensity  Use flat experimental intensity.
%                                 
%    flat_theoretical_intensity   Use flat theoretical intensity.
%                                 
%    through_focus                Use through focus.
%                                 
%    oversample                   Use oversample.
%                                 
%    defocus                      Defocus parameter(mm).
%                                 
%    err_message                  Error message, empty if no error occured.
%                                 
%    strehl_ratio                 Strehl ratio.
%                                 
% 

if nargin ~= 7
	error('The "Imop_HasoField_Strehl" function requires 7 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
strehl_ratio = 0;

[err_nb, err_message, config_file_path, strehl_ratio] = calllib('WaveKitRuntime', 'Imop_HasoField_Strehl', err_message, HasoField, config_file_path, flat_experimental_intensity, flat_theoretical_intensity, through_focus, oversample, defocus, strehl_ratio);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
