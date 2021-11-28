function err_message = Imop_HasoField_Delete(HasoField)

% IMOP_HASOFIELD_DELETE HasoField destructor.
% 
%    HasoField    HasoField object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoField_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoField_Delete', err_message, HasoField);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
