function [err_message, Surface] = Imop_Surface_NewFromCopy(Surface_src)

% IMOP_SURFACE_NEWFROMCOPY Surface constructor from dimensions and steps
% 
%    Surface_src  Pointer to Surface object to copy.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Surface      Pointer to Surface object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_Surface_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Surface = 0;

[err_nb, err_message, Surface] = calllib('WaveKitRuntime', 'Imop_Surface_NewFromCopy', err_message, Surface, Surface_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
