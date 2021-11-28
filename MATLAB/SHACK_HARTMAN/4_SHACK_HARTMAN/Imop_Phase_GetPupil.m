function [err_message, Pupil] = Imop_Phase_GetPupil(Phase, Pupil)

% IMOP_PHASE_GETPUPIL Phase pupil getter.
% 
%    Phase        Phase object adress.
%                 
%    Pupil        pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Phase_GetPupil" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Phase_GetPupil', err_message, Phase, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
