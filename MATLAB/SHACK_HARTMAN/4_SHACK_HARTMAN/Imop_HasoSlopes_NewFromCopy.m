function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromCopy(HasoSlopes_src)

% IMOP_HASOSLOPES_NEWFROMCOPY HasoSlopes constructor from copy
% 
%    HasoSlopes_src  Pointer to HasoSlopes object to copy.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    HasoSlopes      Pointer to HasoSlopes object adress.
%                    
% 

if nargin ~= 1
	error('The "Imop_HasoSlopes_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromCopy', err_message, HasoSlopes, HasoSlopes_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
