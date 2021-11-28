function [err_message, Phase_out] = Imop_Phase_Resize(Phase, resize_factor, do_erode, Phase_out)

% IMOP_PHASE_RESIZE Resize and interpolate Phase
% 
%    Phase          Phase object adress.
%                   
%    resize_factor  resize factor : output phase width (or height) = factor * input phase width (or height).
%                   
%    do_erode       if equal to 1, intensity borders are eroded to avoid weird reconstructed values.
%                   
%    Phase_out      Resized Phase object adress
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 4
	error('The "Imop_Phase_Resize" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Phase_Resize', err_message, Phase, resize_factor, do_erode, Phase_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
