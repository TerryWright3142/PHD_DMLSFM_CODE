function [err_message, value, distance] = Imop_Surface_Projection(Surface, origin_x, origin_y, angle, value, distance)

% IMOP_SURFACE_PROJECTION Not available
% Surface projection on a half-line.
%    Make a projection of a surface along a half-line.
%    The half-line is defined by its origin (origin_x, origin_y)
%    and the angle it forms with vector (1, 0).
%    This origin is also used to locate the points of the half-line where values are
%    given. Indeed, those points are identified by their distance from this
%    origin. Function returns an array of distance and an array of the values of the surface at the
%    corresponding points. Returned distances take surface's steps into account
%    while input angle does not.
%    Surface      Surface object adress.
%                 
%    origin_x     X orign of the half-line.
%                 
%    origin_y     Y origin of the half-line.
%                 
%    angle        Angle of the half-line (degrees).
%                 
%    value        Array of values of the surface.
%                 
%    distance     Array of distance.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 6
	error('The "Imop_Surface_Projection" function requires 6 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, value, distance] = calllib('WaveKitRuntime', 'Imop_Surface_Projection', err_message, Surface, origin_x, origin_y, angle, value, distance);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
