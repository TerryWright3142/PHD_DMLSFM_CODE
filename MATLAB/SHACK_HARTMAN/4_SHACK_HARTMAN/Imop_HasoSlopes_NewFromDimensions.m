function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromDimensions(size, step, serial_number)

% IMOP_HASOSLOPES_NEWFROMDIMENSIONS HasoSlopes constructor from dimensions and steps
% 
%    size           2D subpupils number of the HasoSlopes.
%                   
%    step           2D step of subpupils.
%                   
%    serial_number  Serial number.
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    HasoSlopes     Pointer to HasoSlopes object adress.
%                   
% 

if nargin ~= 3
	error('The "Imop_HasoSlopes_NewFromDimensions" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes, size, step, serial_number] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromDimensions', err_message, HasoSlopes, size, step, serial_number);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
