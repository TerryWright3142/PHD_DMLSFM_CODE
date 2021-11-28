function err_message = Imop_SlopesPostProcessorList_InsertAdder(SlopesPostProcessorList, position, comment, hasoslopes)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTADDER Insert a procAdder "Adder" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    comment                  Comments.
%                             
%    hasoslopes               HasoSlopes to set in the processor.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertAdder" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, comment] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertAdder', err_message, SlopesPostProcessorList, position, comment, hasoslopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
