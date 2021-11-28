function [err_message, Image] = Imop_Image_NewCustom(size, bit_depth, camera_serial, exposure_time_us, gain, nb_summed_images, trigger_type, buffer)

% IMOP_IMAGE_NEWCUSTOM Image constructor from custom data : dimensions, camera serial number, acquisition information, buffer of data.
%    Maximum value in buffer is assessed against the bit depth of the image.
%    Please make sure buffer and image dimensions are coherent.
% 
%    size              2D image size.
%                      
%    bit_depth         Image bits depth.
%                      
%    camera_serial     Camera serial number
%                      
%    exposure_time_us  Exposure duration applied (us).
%                      
%    gain              Applied gain (SI).
%                      
%    nb_summed_images  Number of summed images.
%                      
%    trigger_type      Trigger mode.
%                      
%    buffer            Image data buffer.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    Image             Pointer to Image object adress.
%                      
% 

if nargin ~= 8
	error('The "Imop_Image_NewCustom" function requires 8 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Image = 0;

[err_nb, err_message, Image, size, camera_serial, trigger_type, buffer] = calllib('WaveKitRuntime', 'Imop_Image_NewCustom', err_message, Image, size, bit_depth, camera_serial, exposure_time_us, gain, nb_summed_images, trigger_type, buffer);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
