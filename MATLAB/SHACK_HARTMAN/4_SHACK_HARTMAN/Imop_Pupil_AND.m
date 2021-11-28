function [err_message, Pupil_dst] = Imop_Pupil_AND(Pupil_dst, Pupil)

% IMOP_PUPIL_AND AND operator.
% 
%    Pupil        Pupil object to use in AND operator.
%                 
%    Pupil_dst    Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Pupil_AND" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Pupil_AND', err_message, Pupil_dst, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
