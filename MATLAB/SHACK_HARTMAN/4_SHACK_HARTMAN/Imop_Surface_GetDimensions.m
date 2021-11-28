function [err_message, dimensions, steps] = Imop_Surface_GetDimensions(Surface)

% IMOP_SURFACE_GETDIMENSIONS Get Surface properties.
% 
%    Surface      Surface object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    dimensions   Surface dimensions (width, height).
%                 
%    steps        Physical step x and y between the surface elements (um).
%                 
% 

if nargin ~= 1
	error('The "Imop_Surface_GetDimensions" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_Surface_GetDimensions', err_message, Surface, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
