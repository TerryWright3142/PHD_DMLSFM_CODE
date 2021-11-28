function err_message = Imop_HasoSlopes_SetPupil(HasoSlopes, pupil)

% IMOP_HASOSLOPES_SETPUPIL HasoSlopes pupil object content setter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    pupil        2D buffer containing the subpupils status.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_SetPupil" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, pupil] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_SetPupil', err_message, HasoSlopes, pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
