function err_message = Imop_HasoData_ResetToRawData(HasoData)

% IMOP_HASODATA_RESETTORAWDATA Reset slopes to their raw state and clear process history.
% 
%    HasoData     HasoData object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoData_ResetToRawData" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_ResetToRawData', err_message, HasoData);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
