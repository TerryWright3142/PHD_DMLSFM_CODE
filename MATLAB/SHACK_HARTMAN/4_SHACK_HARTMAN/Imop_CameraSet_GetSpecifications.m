function [err_message, driver_name, camera_name, camera_serial_number, width, height, pixels_stepx, pixels_stepy, bits_depth, is_signed, max_level, max_frame_rate, roi_width, roi_height, roi_offsetx, roi_offsety] = Imop_CameraSet_GetSpecifications(camera_set)

% IMOP_CAMERASET_GETSPECIFICATIONS Camera specifications getter
% 
%    camera_set            CameraSet object adress.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    driver_name           Camera driver name.
%                          
%    camera_name           Camera pretty name.
%                          
%    camera_serial_number  Camera serial number.
%                          
%    width                 Sensor width (pixels).
%                          
%    height                Sensor height (pixels).
%                          
%    pixels_stepx          Pixel width (um).
%                          
%    pixels_stepy          Pixel height (um).
%                          
%    bits_depth            Image dynamic (number of bytes : 1 for 8 bits, 2 for 16 bits ...).
%                          
%    is_signed             Indicates if image data is signed.
%                          
%    max_level             Sensor saturation level (grey level).
%                          
%    max_frame_rate        Camera maximum framerate (image / s).
%                          
%    roi_width             Region of interest width.
%                          
%    roi_height            Region of interest height.
%                          
%    roi_offsetx           Region of interest top-left corner x coordinate (relative to sensor width).
%                          
%    roi_offsety           Region of interest top-left corner y coordinate (relative to sensor height).
%                          
% 

if nargin ~= 1
	error('The "Imop_CameraSet_GetSpecifications" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
driver_name = char(ones(256,1,'int8'));
camera_name = char(ones(256,1,'int8'));
camera_serial_number = char(ones(256,1,'int8'));
width = 0;
height = 0;
pixels_stepx = 0;
pixels_stepy = 0;
bits_depth = 0;
max_level = 0;
max_frame_rate = 0;
roi_width = 0;
roi_height = 0;
roi_offsetx = 0;
roi_offsety = 0;

[err_nb, err_message, driver_name, camera_name, camera_serial_number, width, height, pixels_stepx, pixels_stepy, bits_depth, is_signed, max_level, max_frame_rate, roi_width, roi_height, roi_offsetx, roi_offsety] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetSpecifications', err_message, camera_set, driver_name, camera_name, camera_serial_number, width, height, pixels_stepx, pixels_stepy, bits_depth, is_signed, max_level, max_frame_rate, roi_width, roi_height, roi_offsetx, roi_offsety);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
