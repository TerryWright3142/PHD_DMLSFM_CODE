function err_message = Imop_Surface_SetData(Surface, data)

% IMOP_SURFACE_SETDATA Get write access to Surface buffer.
% 
%    Surface      Surface object adress.
%                 
%    data         Surface buffer to set.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Surface_SetData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, data] = calllib('WaveKitRuntime', 'Imop_Surface_SetData', err_message, Surface, data);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
