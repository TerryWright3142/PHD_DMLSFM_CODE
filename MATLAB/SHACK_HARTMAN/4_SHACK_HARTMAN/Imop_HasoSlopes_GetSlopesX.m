function [err_message, slopes_x] = Imop_HasoSlopes_GetSlopesX(HasoSlopes, slopes_x)

% IMOP_HASOSLOPES_GETSLOPESX HasoSlopes X buffer getter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    slopes_x     2D slopes X buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_GetSlopesX" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, slopes_x] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_GetSlopesX', err_message, HasoSlopes, slopes_x);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
