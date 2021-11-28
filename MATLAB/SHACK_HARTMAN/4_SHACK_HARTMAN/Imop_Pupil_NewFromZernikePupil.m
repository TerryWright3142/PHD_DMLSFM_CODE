function [err_message, Pupil] = Imop_Pupil_NewFromZernikePupil(step, dimensions, center, radius)

% IMOP_PUPIL_NEWFROMZERNIKEPUPIL Circular Pupil constructor from dimensions, steps and circle shape.
% 
%    step         Step x and y between the subpupils (um).
%                 
%    dimensions   Pupil array dimensions (width, height).
%                 
%    center       Center of the circle shape (nb subpupils).
%                 
%    radius       Radius of the circle shape (nb subpupils).
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Pupil        Pointer to Pupil object adress.
%                 
% 

if nargin ~= 4
	error('The "Imop_Pupil_NewFromZernikePupil" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Pupil = 0;

[err_nb, err_message, Pupil, step, dimensions, center] = calllib('WaveKitRuntime', 'Imop_Pupil_NewFromZernikePupil', err_message, Pupil, step, dimensions, center, radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
