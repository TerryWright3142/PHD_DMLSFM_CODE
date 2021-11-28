function err_message = Imop_SlopesPostProcessorList_InsertSlopesPostProcessorList(SlopesPostProcessorList, position, SubSlopesPostProcessorList)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTSLOPESPOSTPROCESSORLIST Insert a SlopesPostProcessorList SubSlopesPostProcessorList in the SlopesPostProcessorList
% 
%    SlopesPostProcessorList     SlopesPostProcessorList object adress.
%                                
%    position                    Position of the processor in the SlopesPostProcessorList.
%                                
%    SubSlopesPostProcessorList  SlopesPostProcessorList object adress.
%                                
%    err_message                 Error message, empty if no error occured.
%                                
% 

if nargin ~= 3
	error('The "Imop_SlopesPostProcessorList_InsertSlopesPostProcessorList" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertSlopesPostProcessorList', err_message, SlopesPostProcessorList, position, SubSlopesPostProcessorList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
