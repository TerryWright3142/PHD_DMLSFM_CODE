function [err_message, Pupil_out] = Imop_Pupil_Resize(Pupil, resize_factor, Pupil_out)

% IMOP_PUPIL_RESIZE Resize pupil.
% 
%    Pupil          Pupil object adress.
%                   
%    resize_factor  resize factor : output pupil width (or height) = factor * input pupil width (or height).
%                   
%    Pupil_out      Resized Pupil object adress
%                   
%    err_message    Error message, empty if no error occured
%                   
% 

if nargin ~= 3
	error('The "Imop_Pupil_Resize" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Pupil_Resize', err_message, Pupil, resize_factor, Pupil_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
