function [err_message, bit_depth, size, time_stamp, haso_serial_number, camera_serial_number, gain, nb_summed_images, exposure_time_requested, exposure_time_applied] = Imop_Image_GetInfo_FromFile(image_file_path)

% IMOP_IMAGE_GETINFO_FROMFILE Get acquisition information from image file.
% 
%    image_file_path          Absolute path to image file.
%                             
%    err_message              Error message, empty if no error occ	ured.
%                             
%    bit_depth                Image bits depth.
%                             
%    size                     Image size.
%                             
%    time_stamp               Acquisition time.
%                             
%    haso_serial_number       Haso serial number.
%                             
%    camera_serial_number     Camera serial number.
%                             
%    gain                     Applied gain (SI).
%                             
%    nb_summed_images         Number summed image.
%                             
%    exposure_time_requested  Exposure duration requested (us).
%                             
%    exposure_time_applied    Exposure duration applied (us).
%                             
% 

if nargin ~= 1
	error('The "Imop_Image_GetInfo_FromFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
bit_depth = 0;
size = [];
time_stamp = 0;
haso_serial_number = char(ones(256,1,'int8'));
camera_serial_number = char(ones(256,1,'int8'));
gain = 0;
nb_summed_images = 0;
exposure_time_requested = 0;
exposure_time_applied = 0;

[err_nb, err_message, image_file_path, bit_depth, size, time_stamp, haso_serial_number, camera_serial_number, gain, nb_summed_images, exposure_time_requested, exposure_time_applied] = calllib('WaveKitRuntime', 'Imop_Image_GetInfo_FromFile', err_message, image_file_path, bit_depth, size, time_stamp, haso_serial_number, camera_serial_number, gain, nb_summed_images, exposure_time_requested, exposure_time_applied);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
