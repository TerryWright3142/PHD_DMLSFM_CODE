function [err_message, Pupil_dst] = Imop_Pupil_OR(Pupil_dst, Pupil)

% IMOP_PUPIL_OR OR operator.
% 
%    Pupil        Pupil object adress to use in OR operator.
%                 
%    Pupil_dst    Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Pupil_OR" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Pupil_OR', err_message, Pupil_dst, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
