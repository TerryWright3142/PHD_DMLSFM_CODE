function [err_message, min, max, fill_percentage] = Imop_Image_GetStatistics(Image, nb_extreme_pixels)

% IMOP_IMAGE_GETSTATISTICS Statistics
% Compute :
%    - The average of the nb_extreme_pixels greatest elements.
%    - The average of the nb_extreme_pixels smallest elements.
%    - The percentage of saturated pixels.
%    Image              Image object adress.
%                       
%    nb_extreme_pixels  Number of pixels to average for min or max computation.
%                       
%    err_message        Error message, empty if no error occured.
%                       
%    min                Average of the nb_extreme_pixels greatest elements.
%                       
%    max                Average of the nb_extreme_pixels smallest elements.
%                       
%    fill_percentage    Percentage of saturated pixels.
%                       
% 

if nargin ~= 2
	error('The "Imop_Image_GetStatistics" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
min = 0;
max = 0;
fill_percentage = 0;

[err_nb, err_message, min, max, fill_percentage] = calllib('WaveKitRuntime', 'Imop_Image_GetStatistics', err_message, Image, nb_extreme_pixels, min, max, fill_percentage);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
