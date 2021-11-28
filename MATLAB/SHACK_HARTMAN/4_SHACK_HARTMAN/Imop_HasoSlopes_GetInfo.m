function [err_message, serial_number, dimensions, steps] = Imop_HasoSlopes_GetInfo(HasoSlopes)

% IMOP_HASOSLOPES_GETINFO HasoSlopes specifications getter.
% 
%    HasoSlopes     HasoSlopes object adress.
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    serial_number  Serial number.
%                   
%    dimensions     Pupil dimensions (width, height)
%                   
%    steps          Subpupil size (um).
%                   
% 

if nargin ~= 1
	error('The "Imop_HasoSlopes_GetInfo" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
serial_number = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, serial_number, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_GetInfo', err_message, HasoSlopes, serial_number, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
