function [err_message, buffer, Pupil] = Imop_Phase_GetData(Phase, buffer, Pupil)

% IMOP_PHASE_GETDATA Phase values buffer and pupil getter.
% 
%    Phase        Phase object adress.
%                 
%    buffer       Phase values buffer.
%                 
%    Pupil        pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 3
	error('The "Imop_Phase_GetData" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, buffer] = calllib('WaveKitRuntime', 'Imop_Phase_GetData', err_message, Phase, buffer, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
