function [err_message, pupil] = Imop_Pupil_NewFromCopy(pupil_to_copy)

% IMOP_PUPIL_NEWFROMCOPY Pupil constructor from copy
% 
%    pupil_to_copy  Pointer to Pupil object adress to copy
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    pupil          Pointer to Pupil object adress.
%                   
% 

if nargin ~= 1
	error('The "Imop_Pupil_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
pupil = 0;

[err_nb, err_message, pupil] = calllib('WaveKitRuntime', 'Imop_Pupil_NewFromCopy', err_message, pupil, pupil_to_copy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
