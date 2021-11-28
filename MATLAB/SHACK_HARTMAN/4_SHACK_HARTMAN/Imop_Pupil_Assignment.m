function [err_message, Pupil_dst] = Imop_Pupil_Assignment(Pupil_dst, Pupil_src)

% IMOP_PUPIL_ASSIGNMENT Deep copy.
% 
%    Pupil_src    Pupil object adress to copy.
%                 
%    Pupil_dst    Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Pupil_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Pupil_Assignment', err_message, Pupil_dst, Pupil_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
