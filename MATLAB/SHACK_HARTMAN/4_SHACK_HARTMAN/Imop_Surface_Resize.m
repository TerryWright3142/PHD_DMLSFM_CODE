function [err_message, Surface_out] = Imop_Surface_Resize(Surface, resize_factor, Surface_out)

% IMOP_SURFACE_RESIZE Not available
% Surface resize.
%    Surface        Surface object adress.
%                   
%    resize_factor  Resize factor factor.
%                   
%    Surface_out    Resized surface.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin ~= 3
	error('The "Imop_Surface_Resize" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Surface_Resize', err_message, Surface, resize_factor, Surface_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
