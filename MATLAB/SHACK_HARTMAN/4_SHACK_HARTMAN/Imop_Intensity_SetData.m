function err_message = Imop_Intensity_SetData(Intensity, buffer, Pupil)

% IMOP_INTENSITY_SETDATA Intensity values buffer and pupil setter.
% 
%    Intensity    object adress.
%                 
%    buffer       values buffer.
%                 
%    Pupil        pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 3
	error('The "Imop_Intensity_SetData" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Intensity_SetData', err_message, Intensity, buffer, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
