function [err_message, energy] = Imop_Surface_EncircledEnergy(Surface, center, radius)

% IMOP_SURFACE_ENCIRCLEDENERGY Compute the sum of the values for pixels inside the specified circle.
%    i.e. sum of the pixel values inside the circle.
%    To be consistent with Imop_Surface_BoundingShapes, Surface must be normalized, i.e. sum(pixels of surface = 1 -> see Imop_Surface_BoundingShapes method)
% 
%    Surface      Surface object adress.
%                 
%    center       Circle center coordinates.
%                 
%    radius       Circle width and height
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    energy       Encircled energy
%                 
% 

if nargin ~= 3
	error('The "Imop_Surface_EncircledEnergy" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
energy = 0;

[err_nb, err_message, center, energy] = calllib('WaveKitRuntime', 'Imop_Surface_EncircledEnergy', err_message, Surface, center, radius, energy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
