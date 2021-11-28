function err_message = Imop_SlopesPostProcessorList_InsertNeighborExtension(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTNEIGHBOREXTENSION Insert a procNeighborExtension "NeighborExtension" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_InsertNeighborExtension" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertNeighborExtension', err_message, SlopesPostProcessorList, position);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
