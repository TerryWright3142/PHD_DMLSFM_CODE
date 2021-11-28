function [err_message, intensity] = Imop_HasoSlopes_GetIntensity(HasoSlopes, intensity)

% IMOP_HASOSLOPES_GETINTENSITY HasoSlopes intensity buffer getter.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    intensity    2D Intensity buffer
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_GetIntensity" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, intensity] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_GetIntensity', err_message, HasoSlopes, intensity);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
