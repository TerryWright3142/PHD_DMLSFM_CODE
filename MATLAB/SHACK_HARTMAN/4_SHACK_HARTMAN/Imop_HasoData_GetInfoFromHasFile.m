function [err_message, haso_model, haso_serial_number, revision, size, step, time_stamp, comments, session_name, wavelength_nm, lower_calibration_wl, upper_calibration_wl] = Imop_HasoData_GetInfoFromHasFile(has_file_path)

% IMOP_HASODATA_GETINFOFROMHASFILE Get informations from .has file.
% 
%    has_file_path         Absolute path to the .has file.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    haso_model            Haso Sensor model.
%                          
%    haso_serial_number    Haso Serial number.
%                          
%    revision              Revision number.
%                          
%    size                  HasoData dimension (subpupil number)
%                          
%    step                  HasoData sampling step (um).
%                          
%    time_stamp            Timestamp.
%                          
%    comments              Comments
%                          
%    session_name          Session name.
%                          
%    wavelength_nm         Source wavelength (nm).
%                          
%    lower_calibration_wl  Lower calibration wavelength (nm).
%                          
%    upper_calibration_wl  Upper calibration wavelength (nm).
%                          
% 

if nargin ~= 1
	error('The "Imop_HasoData_GetInfoFromHasFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
haso_model = char(ones(256,1,'int8'));
haso_serial_number = char(ones(256,1,'int8'));
size = [];
step = [];
time_stamp = 0;
comments = char(ones(256,1,'int8'));
session_name = char(ones(256,1,'int8'));
wavelength_nm = 0;
lower_calibration_wl = 0;
upper_calibration_wl = 0;

[err_nb, err_message, has_file_path, haso_model, haso_serial_number, revision, size, step, time_stamp, comments, session_name, wavelength_nm, lower_calibration_wl, upper_calibration_wl] = calllib('WaveKitRuntime', 'Imop_HasoData_GetInfoFromHasFile', err_message, has_file_path, haso_model, haso_serial_number, revision, size, step, time_stamp, comments, session_name, wavelength_nm, lower_calibration_wl, upper_calibration_wl);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
