function [err_message, SurfaceTransformed] = Imop_Surface_TransposeAndFlip(Surface, do_transpose, do_flip_x, do_flip_y, SurfaceTransformed)

% IMOP_SURFACE_TRANSPOSEANDFLIP Operate an optionnal transposition on Surface (swap x and y)
%    followed by optionnal flip x then flip y transformations.
% 
%    Surface             Surface object adress, modified by the function if SurfaceTransformed = NULL.
%                        
%    do_transpose        if true, resulting Surface is transposed.
%                        
%    do_flip_x           if true, resulting Surface is flipped along x axis (horizontal flip).
%                        
%    do_flip_y           if true, resulting Surface is flipped along y axis (vertical flip).
%                        
%    SurfaceTransformed  Transformed surface if not NULL.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin < 4
	error('The "Imop_Surface_TransposeAndFlip" function requires at least 4 input argument(s).');
elseif nargin > 5
	error('The "Imop_Surface_TransposeAndFlip" function cannot have more than 5 input argument(s).');
end
if nargin<=4
	SurfaceTransformed=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Surface_TransposeAndFlip', err_message, Surface, do_transpose, do_flip_x, do_flip_y, SurfaceTransformed);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
