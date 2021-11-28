function [err_message, data] = Imop_Surface_GetData(Surface, data)

% IMOP_SURFACE_GETDATA Get read access to Surface buffer.
% 
%    Surface      Surface object adress.
%                 
%    data         Surface buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_Surface_GetData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, data] = calllib('WaveKitRuntime', 'Imop_Surface_GetData', err_message, Surface, data);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
