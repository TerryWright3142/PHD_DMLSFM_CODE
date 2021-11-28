function [err_message, Pupil] = Imop_Pupil_NewFromDimensions(dimensions, steps, value)

% IMOP_PUPIL_NEWFROMDIMENSIONS Pupil constructor from dimensions, steps and inital value.
% 
%    dimensions   Pupil array dimensions (width, height).
%                 
%    steps        Step x and y between the subpupils (um).
%                 
%    value        Inital value.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Pupil        Pointer to Pupil object adress.
%                 
% 

if nargin ~= 3
	error('The "Imop_Pupil_NewFromDimensions" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Pupil = 0;

[err_nb, err_message, Pupil, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_Pupil_NewFromDimensions', err_message, Pupil, dimensions, steps, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
