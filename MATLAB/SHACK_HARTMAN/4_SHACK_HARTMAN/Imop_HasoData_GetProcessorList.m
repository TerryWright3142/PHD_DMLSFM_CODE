function [err_message, SlopesPostProcessorList] = Imop_HasoData_GetProcessorList(HasoData, SlopesPostProcessorList)

% IMOP_HASODATA_GETPROCESSORLIST SlopesPostProcessorList getter.
% 
%    HasoData                 HasoData object adress.
%                             
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 2
	error('The "Imop_HasoData_GetProcessorList" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_GetProcessorList', err_message, HasoData, SlopesPostProcessorList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
