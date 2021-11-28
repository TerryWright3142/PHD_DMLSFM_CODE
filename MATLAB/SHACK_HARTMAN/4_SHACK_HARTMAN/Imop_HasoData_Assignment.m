function [err_message, HasoData_dst] = Imop_HasoData_Assignment(HasoData_dst, HasoData_src)

% IMOP_HASODATA_ASSIGNMENT HasoData deep copy.
% 
%    HasoData_src  HasoData object adress source.
%                  
%    HasoData_dst  HasoData object adress destination.
%                  
%    err_message   Error message, empty if no error occured.
%                  
% 

if nargin ~= 2
	error('The "Imop_HasoData_Assignment" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_Assignment', err_message, HasoData_dst, HasoData_src);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
