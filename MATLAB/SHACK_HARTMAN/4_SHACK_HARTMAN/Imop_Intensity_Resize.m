function [err_message, Intensity_out] = Imop_Intensity_Resize(Intensity, resize_factor, do_erode, Intensity_out)

% IMOP_INTENSITY_RESIZE Resize and interpolate Intensity
% 
%    Intensity      Intensity object adress.
%                   
%    resize_factor  resize factor : output intensity width (or height) = factor * input intensity width (or height).
%                   
%    do_erode       if equal to 1, intensity borders are eroded to avoid weird reconstructed values.
%                   
%    Intensity_out  Resized Intensity object adress
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 4
	error('The "Imop_Intensity_Resize" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Intensity_Resize', err_message, Intensity, resize_factor, do_erode, Intensity_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
