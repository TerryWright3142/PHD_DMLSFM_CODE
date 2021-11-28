function err_message = Imop_HasoSlopes_GetPupilPointer(HasoSlopes, Pupil)

% IMOP_HASOSLOPES_GETPUPILPOINTER HasoSlopes pointer to pupil object getter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    Pupil        Pointer to pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_GetPupilPointer" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, Pupil] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_GetPupilPointer', err_message, HasoSlopes, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
