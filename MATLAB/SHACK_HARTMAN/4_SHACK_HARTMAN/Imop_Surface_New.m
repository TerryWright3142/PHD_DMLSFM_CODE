function [err_message, Surface] = Imop_Surface_New(dimensions, step)

% IMOP_SURFACE_NEW Surface constructor from dimensions and steps
% 
%    dimensions   Surface dimensions (width, height).
%                 
%    step         Physical step x and y between the surface elements (um).
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Surface      Pointer to Surface object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Surface_New" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Surface = 0;

[err_nb, err_message, dimensions, step, Surface] = calllib('WaveKitRuntime', 'Imop_Surface_New', err_message, dimensions, step, Surface);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
