function err_message = Imop_SlopesPostProcessorList_InsertSubstractor(SlopesPostProcessorList, position, comment, HasoSlopes)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTSUBSTRACTOR Insert a procSubstractor "Substractor" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    comment                  Comments.
%                             
%    HasoSlopes               HasoSlopes to set in the processor.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertSubstractor" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, comment] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertSubstractor', err_message, SlopesPostProcessorList, position, comment, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
