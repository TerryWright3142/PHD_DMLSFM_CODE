function [err_message, exposure_time_requested, exposure_time_applied, gain, nb_summed_images, trigger_type] = Imop_Image_GetAcquisitionInfo(Image)

% IMOP_IMAGE_GETACQUISITIONINFO Get acquisition information from Image object.
% 
%    Image                    Image object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    exposure_time_requested  Exposure duration requested (us).
%                             
%    exposure_time_applied    Exposure duration applied (us).
%                             
%    gain                     Applied gain (SI).
%                             
%    nb_summed_images         Number of summed images.
%                             
%    trigger_type             Trigger mode.
%                             
% 

if nargin ~= 1
	error('The "Imop_Image_GetAcquisitionInfo" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
exposure_time_requested = 0;
exposure_time_applied = 0;
gain = 0;
nb_summed_images = 0;
trigger_type = char(ones(256,1,'int8'));

[err_nb, err_message, exposure_time_requested, exposure_time_applied, gain, nb_summed_images, trigger_type] = calllib('WaveKitRuntime', 'Imop_Image_GetAcquisitionInfo', err_message, Image, exposure_time_requested, exposure_time_applied, gain, nb_summed_images, trigger_type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
