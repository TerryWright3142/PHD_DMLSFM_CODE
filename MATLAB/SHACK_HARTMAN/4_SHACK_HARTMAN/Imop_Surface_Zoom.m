function [err_message, SurfaceZoomed] = Imop_Surface_Zoom(Surface, factor, SurfaceZoomed)

% IMOP_SURFACE_ZOOM Not available
% Surface zoom.
%    Surface        Surface object adress.
%                   
%    factor         Zoom factor.
%                   
%    SurfaceZoomed  Zoomed surface.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 3
	error('The "Imop_Surface_Zoom" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Surface_Zoom', err_message, Surface, factor, SurfaceZoomed);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
