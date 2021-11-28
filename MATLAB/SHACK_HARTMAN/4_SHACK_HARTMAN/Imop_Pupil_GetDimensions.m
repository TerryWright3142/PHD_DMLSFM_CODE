function [err_message, dimensions, steps] = Imop_Pupil_GetDimensions(Pupil)

% IMOP_PUPIL_GETDIMENSIONS Get Pupil dimensions and steps.
% 
%    Pupil        Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    dimensions   Pupil array dimensions (width, height).
%                 
%    steps        Step x and y between the subpupils (um).
%                 
% 

if nargin ~= 1
	error('The "Imop_Pupil_GetDimensions" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_Pupil_GetDimensions', err_message, Pupil, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
