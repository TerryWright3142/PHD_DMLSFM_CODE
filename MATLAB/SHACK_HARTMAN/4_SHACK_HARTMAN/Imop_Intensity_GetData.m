function [err_message, buffer, Pupil] = Imop_Intensity_GetData(Intensity, buffer, Pupil)

% IMOP_INTENSITY_GETDATA Intensity values buffer and pupil getter.
% 
%    Intensity    Intensity object adress.
%                 
%    buffer       Intensity values buffer.
%                 
%    Pupil        pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 3
	error('The "Imop_Intensity_GetData" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Intensity_GetData', err_message, Intensity, buffer, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
