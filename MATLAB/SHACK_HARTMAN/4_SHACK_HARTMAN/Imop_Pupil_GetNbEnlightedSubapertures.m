function [err_message, nb_enlighted_subapertures] = Imop_Pupil_GetNbEnlightedSubapertures(Pupil)

% IMOP_PUPIL_GETNBENLIGHTEDSUBAPERTURES Get Pupil enlighted subapertures number
% 
%    Pupil                      Pupil object adress.
%                               
%    err_message                Error message, empty if no error occured.
%                               
%    nb_enlighted_subapertures  Number of enlighted subapertures
%                               
% 

if nargin ~= 1
	error('The "Imop_Pupil_GetNbEnlightedSubapertures" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_enlighted_subapertures = 0;

[err_nb, err_message, nb_enlighted_subapertures] = calllib('WaveKitRuntime', 'Imop_Pupil_GetNbEnlightedSubapertures', err_message, Pupil, nb_enlighted_subapertures);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
