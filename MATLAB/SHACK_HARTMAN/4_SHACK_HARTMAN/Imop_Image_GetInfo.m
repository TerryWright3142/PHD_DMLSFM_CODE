function [err_message, camera_serial_number, time_stamp, comments, is_smearing_removed, is_background_removed, max_level] = Imop_Image_GetInfo(Image)

% IMOP_IMAGE_GETINFO Get metadata from Image object.
% 
%    Image                  Image object adress.
%                           
%    err_message            Error message, empty if no error occured.
%                           
%    camera_serial_number   Camera serial number.
%                           
%    time_stamp             Date of the acquired Image.
%                           
%    comments               Comments.
%                           
%    is_smearing_removed    Smearing_removed.
%                           
%    is_background_removed  Background_removed.
%                           
%    max_level              Max level value.
%                           
% 

if nargin ~= 1
	error('The "Imop_Image_GetInfo" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
camera_serial_number = char(ones(256,1,'int8'));
time_stamp = 0;
comments = char(ones(256,1,'int8'));
is_smearing_removed = 0;
is_background_removed = 0;
max_level = 0;

[err_nb, err_message, camera_serial_number, time_stamp, comments, is_smearing_removed, is_background_removed, max_level] = calllib('WaveKitRuntime', 'Imop_Image_GetInfo', err_message, Image, camera_serial_number, time_stamp, comments, is_smearing_removed, is_background_removed, max_level);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
