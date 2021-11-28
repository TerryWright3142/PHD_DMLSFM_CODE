function err_message = Imop_HasoSlopes_Assignment(HasoSlopes_dst, HasoSlopes_src)

% IMOP_HASOSLOPES_ASSIGNMENT HasoSlopes deep copy.
% 
%    HasoSlopes_dst  HasoSlopes object adress to copy to.
%                    
%    HasoSlopes_src  HasoSlopes object adress to copy from.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_Assignment', err_message, HasoSlopes_dst, HasoSlopes_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
