function [err_message, SlopesPostProcessor] = Imop_SlopesPostProcessorList_NewFromHasFile(HAS_FilePath)

% IMOP_SLOPESPOSTPROCESSORLIST_NEWFROMHASFILE SlopesPostProcessorList constructor from a .has file
% 
%    HAS_FilePath         Path to .has file.
%                         
%    err_message          Error message, empty if no error occured.
%                         
%    SlopesPostProcessor  Pointer to SlopesPostProcessorList object adress.
%                         
% 

if nargin ~= 1
	error('The "Imop_SlopesPostProcessorList_NewFromHasFile" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
SlopesPostProcessor = 0;

[err_nb, err_message, SlopesPostProcessor, HAS_FilePath] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_NewFromHasFile', err_message, SlopesPostProcessor, HAS_FilePath);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
