function [err_message, size] = Imop_SlopesPostProcessorList_GetProcessorListSize(SlopesPostProcessorList)

% IMOP_SLOPESPOSTPROCESSORLIST_GETPROCESSORLISTSIZE Get the size of the SlopesPostProcessorList
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    size                     Processor list size.
%                             
% 

if nargin ~= 1
	error('The "Imop_SlopesPostProcessorList_GetProcessorListSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = 0;

[err_nb, err_message, size] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetProcessorListSize', err_message, SlopesPostProcessorList, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
