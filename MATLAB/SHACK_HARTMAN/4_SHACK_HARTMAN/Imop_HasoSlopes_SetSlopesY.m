function err_message = Imop_HasoSlopes_SetSlopesY(HasoSlopes, slopes_y)

% IMOP_HASOSLOPES_SETSLOPESY HasoSlopes Y buffer setter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    slopes_y     2D slopes Y buffer.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_SetSlopesY" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, slopes_y] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_SetSlopesY', err_message, HasoSlopes, slopes_y);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
