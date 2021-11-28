function [err_message, data] = Imop_Pupil_GetData(Pupil, data)

% IMOP_PUPIL_GETDATA Get Pupil buffer.
% 
%    Pupil        Pupil object adress.
%                 
%    data         Pupil buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Pupil_GetData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, data] = calllib('WaveKitRuntime', 'Imop_Pupil_GetData', err_message, Pupil, data);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
