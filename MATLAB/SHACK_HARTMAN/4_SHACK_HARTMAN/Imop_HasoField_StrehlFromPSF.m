function [err_message, strehl_ratio] = Imop_HasoField_StrehlFromPSF(HasoField, config_file_path, experimental_psf, theoretical_psf, oversample)

% IMOP_HASOFIELD_STREHLFROMPSF Strehl ratio from PSF function
% This function Strehl ratio from experimental and theoretical point
%    spread functions (PSF).
%    There is also an option to oversample both PSF surfaces before ratio computation.
%    HasoField         HasoField object adress.
%                      
%    config_file_path  Absolute path to the Haso configuration file.
%                      
%    experimental_psf  Experimental psf values.
%                      
%    theoretical_psf   Theoretical psf values.
%                      
%    oversample        Use oversample.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    strehl_ratio      Strehl ratio.
%                      
% 

if nargin ~= 5
	error('The "Imop_HasoField_StrehlFromPSF" function requires 5 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
strehl_ratio = 0;

[err_nb, err_message, config_file_path, strehl_ratio] = calllib('WaveKitRuntime', 'Imop_HasoField_StrehlFromPSF', err_message, HasoField, config_file_path, experimental_psf, theoretical_psf, oversample, strehl_ratio);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
