function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyPupil(Slopes_in, Pupil, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYPUPIL Replaces the slopes pupil by the intersection of the current one with the given one.
% 
%    Pupil        pupil object adress.
%                 
%    Slopes_in    HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                 
%    Slopes_out   processed HasoSlopes object adress if not NULL.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin < 2
	error('The "Imop_SlopesPostProcessor_ApplyPupil" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_SlopesPostProcessor_ApplyPupil" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyPupil', err_message, Slopes_in, Pupil, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
