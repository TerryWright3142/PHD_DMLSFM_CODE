function [err_message, Pupil] = Imop_Pupil_NewFromHasoSlopes(HasoSlopes)

% IMOP_PUPIL_NEWFROMHASOSLOPES Pupil constructor from HasoSlopes.
% 
%    HasoSlopes   HasoSlopes input.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Pupil        Pointer to Pupil object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_Pupil_NewFromHasoSlopes" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Pupil = 0;

[err_nb, err_message, Pupil] = calllib('WaveKitRuntime', 'Imop_Pupil_NewFromHasoSlopes', err_message, Pupil, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
