function [err_message, Intensity] = Imop_Intensity_NewFromSlopes(HasoSlopes)

% IMOP_INTENSITY_NEWFROMSLOPES Intensity constructor from HasoSlopes.
%    Extract intensity values from HasoSlopes object and builds Intensity object
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Intensity    Pointer to Intensity object adress. Intensity sampling steps unit is um.
%                 
% 

if nargin ~= 1
	error('The "Imop_Intensity_NewFromSlopes" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Intensity = 0;

[err_nb, err_message, Intensity] = calllib('WaveKitRuntime', 'Imop_Intensity_NewFromSlopes', err_message, Intensity, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
