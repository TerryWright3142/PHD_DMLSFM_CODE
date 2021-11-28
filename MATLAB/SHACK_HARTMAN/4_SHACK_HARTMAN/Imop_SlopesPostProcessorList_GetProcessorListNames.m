function [err_message, listname] = Imop_SlopesPostProcessorList_GetProcessorListNames(SlopesPostProcessorList)

% IMOP_SLOPESPOSTPROCESSORLIST_GETPROCESSORLISTNAMES Get names of the the SlopesPostProcessors contained into the SlopesPostProcessorList.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    listname                 List of processors names.
%                             
% 

if nargin ~= 1
	error('The "Imop_SlopesPostProcessorList_GetProcessorListNames" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
listname = char(ones(256,1,'int8'));

[err_nb, err_message, listname] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetProcessorListNames', err_message, SlopesPostProcessorList, listname);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
