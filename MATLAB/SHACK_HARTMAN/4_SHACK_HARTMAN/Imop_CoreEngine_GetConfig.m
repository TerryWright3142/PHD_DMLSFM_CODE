function [err_message, serial_number, revision, model, nb_subpupils, ulens_step, alignment_position_pixels, tolerance_radius, default_start_subpupil, lower_calibration_wavelength, upper_calibration_wavelength, black_subpupil_position, tilt_limit_mrad, radius, microlens_focal, smearing_limit_wavelength, smearing_limit_exposure_duration, internal_options_list, software_info_list, SdkInfoList] = Imop_CoreEngine_GetConfig(config_file_path)

% IMOP_COREENGINE_GETCONFIG Haso configuration information getter.
% 
%    config_file_path                  Absolute path to Haso configuration file.
%                                      
%    err_message                       Error message, empty if no error occured.
%                                      
%    serial_number                     Haso Serial number.
%                                      
%    revision                          Revision number.
%                                      
%    model                             Model name.
%                                      
%    nb_subpupils                      Sensor size (width, height).
%                                      
%    ulens_step                        Step x and y between the subpupils (um).
%                                      
%    alignment_position_pixels         Reference (in pixels), used when aligning sensor.
%                                      
%    tolerance_radius                  Tolerance (in pixels) that indicates that the sensor is aligned.
%                                      
%    default_start_subpupil            Coordinates of the first calculated sub-aperture, in subaperture index.
%                                      
%    lower_calibration_wavelength      Lower calibration wavelength (nm).
%                                      
%    upper_calibration_wavelength      Upper calibration wavelength (nm).
%                                      
%    black_subpupil_position           Position of the black subpupil, in subaperture index
%                                      
%    tilt_limit_mrad                   Not used for the time being.
%                                      
%    radius                            Not used for the time being.
%                                      
%    microlens_focal                   Microlens focal.
%                                      
%    smearing_limit_wavelength         Not used for the time being.
%                                      
%    smearing_limit_exposure_duration  Not used for the time being.
%                                      
%    internal_options_list             List of the allowed options
%                                      
%    software_info_list                List of the allowed specific software functionnalities.
%                                      
%    SdkInfoList                       List of the allowed specific SDK functionnalities.
%                                      
% 

if nargin ~= 1
	error('The "Imop_CoreEngine_GetConfig" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
serial_number = char(ones(256,1,'int8'));
revision = 0;
model = char(ones(256,1,'int8'));
nb_subpupils = [];
ulens_step = [];
alignment_position_pixels = [];
tolerance_radius = 0;
default_start_subpupil = [];
lower_calibration_wavelength = 0;
upper_calibration_wavelength = 0;
black_subpupil_position = [];
tilt_limit_mrad = 0;
radius = 0;
microlens_focal = 0;
smearing_limit_wavelength = 0;
smearing_limit_exposure_duration = 0;
internal_options_list = char(ones(256,1,'int8'));
software_info_list = char(ones(256,1,'int8'));
SdkInfoList = char(ones(256,1,'int8'));

[err_nb, err_message, config_file_path, serial_number, revision, model, nb_subpupils, ulens_step, alignment_position_pixels, tolerance_radius, default_start_subpupil, lower_calibration_wavelength, upper_calibration_wavelength, black_subpupil_position, tilt_limit_mrad, radius, microlens_focal, smearing_limit_wavelength, smearing_limit_exposure_duration, internal_options_list, software_info_list, SdkInfoList] = calllib('WaveKitRuntime', 'Imop_CoreEngine_GetConfig', err_message, config_file_path, serial_number, revision, model, nb_subpupils, ulens_step, alignment_position_pixels, tolerance_radius, default_start_subpupil, lower_calibration_wavelength, upper_calibration_wavelength, black_subpupil_position, tilt_limit_mrad, radius, microlens_focal, smearing_limit_wavelength, smearing_limit_exposure_duration, internal_options_list, software_info_list, SdkInfoList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
