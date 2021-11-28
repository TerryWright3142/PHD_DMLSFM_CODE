function [err_message, dimensions, steps] = Imop_Intensity_GetDimensionsAndSteps(Intensity)

% IMOP_INTENSITY_GETDIMENSIONSANDSTEPS Get Intensity dimensions
% 
%    Intensity    Intensity object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    dimensions   Intensity dimensions as the (width, height) of the pupil.
%                 
%    steps        Intensity sampling steps in x and y direction (um).
%                 
% 

if nargin ~= 1
	error('The "Imop_Intensity_GetDimensionsAndSteps" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_Intensity_GetDimensionsAndSteps', err_message, Intensity, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
