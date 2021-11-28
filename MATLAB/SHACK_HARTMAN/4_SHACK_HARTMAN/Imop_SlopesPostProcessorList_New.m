function [err_message, SlopesPostProcessorList] = Imop_SlopesPostProcessorList_New()

% IMOP_SLOPESPOSTPROCESSORLIST_NEW SlopesPostProcessorList default constructor
% 
%    err_message              Error message, empty if no error occured.
%                             
%    SlopesPostProcessorList  Pointer to SlopesPostProcessorList object adress.
%                             
% 

if nargin ~= 0
	error('The "Imop_SlopesPostProcessorList_New" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
SlopesPostProcessorList = 0;

[err_nb, err_message, SlopesPostProcessorList] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_New', err_message, SlopesPostProcessorList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
