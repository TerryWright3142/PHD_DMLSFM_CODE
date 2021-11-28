function [err_message, haso_model, haso_serial_number, camera_serial_number, revision, lower_calibration_wl, upper_calibration_wl, exposure_time_requested, exposure_time_applied, nb_summed_images, time_stamp, is_background_removed, is_smearing_removed, wavelength_nm, session_name, trigger_type, comments, max_level, start_subpupil] = Imop_HasoData_GetInfo(HasoData, denoising_strength)

% IMOP_HASODATA_GETINFO Get informations from HasoData object.
% 
%    HasoData                 HasoData object adress.
%                             
%    denoising_strength       Sensitivity of spot detection (between 0 and 1).
%                             Modulates noise management when computing slopes on summed images.
%                             - 0 : Release constraint on noise to detect as much sub-pupils as possible.
%                             - 1 : Do not take into account the noise reduction caused by summing.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    haso_model               Sensor model.
%                             
%    haso_serial_number       Haso serial number.
%                             
%    camera_serial_number     Camera serial number.
%                             
%    revision                 Revision number.
%                             
%    lower_calibration_wl     Lower calibration wavelength (nm).
%                             
%    upper_calibration_wl     Upper calibration wavelength (nm).
%                             
%    exposure_time_requested  Exposure duration requested, in microsecond.
%                             
%    exposure_time_applied    Exposure duration applied, in microsecond.
%                             
%    nb_summed_images         Number of summed images.
%                             
%    time_stamp               Timestamp.
%                             
%    is_background_removed    Background removed value.
%                             
%    is_smearing_removed      Smearing removed value.
%                             
%    wavelength_nm            Source wavelength (nm).
%                             
%    session_name             Session name.
%                             
%    trigger_type             Trigger mode.
%                             
%    comments                 Comments.
%                             
%    max_level                Max level value.
%                             
%    start_subpupil           Start subpupil position (um)
%                             
% 

if nargin ~= 2
	error('The "Imop_HasoData_GetInfo" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
haso_model = char(ones(256,1,'int8'));
haso_serial_number = char(ones(256,1,'int8'));
camera_serial_number = char(ones(256,1,'int8'));
lower_calibration_wl = 0;
upper_calibration_wl = 0;
time_stamp = 0;
is_background_removed = 0;
is_smearing_removed = 0;
wavelength_nm = 0;
session_name = char(ones(256,1,'int8'));
trigger_type = char(ones(256,1,'int8'));
comments = char(ones(256,1,'int8'));
max_level = 0;
start_subpupil = [];

[err_nb, err_message, haso_model, haso_serial_number, camera_serial_number, revision, lower_calibration_wl, upper_calibration_wl, exposure_time_requested, exposure_time_applied, nb_summed_images, time_stamp, is_background_removed, is_smearing_removed, wavelength_nm, session_name, trigger_type, comments, max_level, start_subpupil, denoising_strength] = calllib('WaveKitRuntime', 'Imop_HasoData_GetInfo', err_message, HasoData, haso_model, haso_serial_number, camera_serial_number, revision, lower_calibration_wl, upper_calibration_wl, exposure_time_requested, exposure_time_applied, nb_summed_images, time_stamp, is_background_removed, is_smearing_removed, wavelength_nm, session_name, trigger_type, comments, max_level, start_subpupil, denoising_strength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
