function [err_message, Intensity] = Imop_Intensity_NewFromDimAndSteps(dimensions, step)

% IMOP_INTENSITY_NEWFROMDIMANDSTEPS Intensity constructor from dimensions and steps.
% All the elements of the Phase values buffer are set to zero and the elements
%    of the pupil are set to true.
%    dimensions   Intensity dimensions as the (width, height) of the pupil.
%                 
%    step         Intensity sampling steps in x and y direction (um).
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Intensity    Pointer to Intensity object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Intensity_NewFromDimAndSteps" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Intensity = 0;

[err_nb, err_message, dimensions, step, Intensity] = calllib('WaveKitRuntime', 'Imop_Intensity_NewFromDimAndSteps', err_message, dimensions, step, Intensity);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
