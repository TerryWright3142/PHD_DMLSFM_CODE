function [err_message, Pupil] = Imop_Pupil_INVERT(Pupil)

% IMOP_PUPIL_INVERT INVERT operator.
% 
%    Pupil        Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 1
	error('The "Imop_Pupil_INVERT" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Pupil_INVERT', err_message, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
