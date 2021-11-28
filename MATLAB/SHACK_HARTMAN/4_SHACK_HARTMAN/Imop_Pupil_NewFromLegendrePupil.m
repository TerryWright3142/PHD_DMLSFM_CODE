function [err_message, Pupil] = Imop_Pupil_NewFromLegendrePupil(step, dimensions, center, rectangle_size)

% IMOP_PUPIL_NEWFROMLEGENDREPUPIL Rectangular Pupil constructor from dimensions, steps and rectangle shape.
% 
%    step            Step x and y between the subpupils (um).
%                    
%    dimensions      Pupil array dimensions (width, height).
%                    
%    center          Center of the rectangle shape (nb subpupils).
%                    
%    rectangle_size  Shape (half-width, half-height) of the rectangle (nb subpupils).
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    Pupil           Pointer to Pupil object adress.
%                    
% 

if nargin ~= 4
	error('The "Imop_Pupil_NewFromLegendrePupil" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Pupil = 0;

[err_nb, err_message, Pupil, step, dimensions, center, rectangle_size] = calllib('WaveKitRuntime', 'Imop_Pupil_NewFromLegendrePupil', err_message, Pupil, step, dimensions, center, rectangle_size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
