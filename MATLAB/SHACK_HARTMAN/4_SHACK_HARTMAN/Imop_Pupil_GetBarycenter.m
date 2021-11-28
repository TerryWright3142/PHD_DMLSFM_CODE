function [err_message, barycenter] = Imop_Pupil_GetBarycenter(Pupil)

% IMOP_PUPIL_GETBARYCENTER Get Pupil barycenter.
% 
%    Pupil        Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    barycenter   Pupil barycenter.
%                 
% 

if nargin ~= 1
	error('The "Imop_Pupil_GetBarycenter" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
barycenter = [];

[err_nb, err_message, barycenter] = calllib('WaveKitRuntime', 'Imop_Pupil_GetBarycenter', err_message, Pupil, barycenter);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
