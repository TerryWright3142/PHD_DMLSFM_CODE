function [err_message, NewSlopesPostProcessorList] = Imop_SlopesPostProcessorList_NewFromCopy(SlopesPostProcessorListSrc)

% IMOP_SLOPESPOSTPROCESSORLIST_NEWFROMCOPY SlopesPostProcessorList constructor from copy
% 
%    SlopesPostProcessorListSrc  SlopesPostProcessorList source object adress.
%                                
%    err_message                 Error message, empty if no error occured.
%                                
%    NewSlopesPostProcessorList  Pointer to SlopesPostProcessorList object adress.
%                                
% 

if nargin ~= 1
	error('The "Imop_SlopesPostProcessorList_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
NewSlopesPostProcessorList = 0;

[err_nb, err_message, NewSlopesPostProcessorList] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_NewFromCopy', err_message, NewSlopesPostProcessorList, SlopesPostProcessorListSrc);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
