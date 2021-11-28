function [err_message, comment, hasoslopes] = Imop_SlopesPostProcessorList_GetAdderParameters(SlopesPostProcessorList, position, hasoslopes)

% IMOP_SLOPESPOSTPROCESSORLIST_GETADDERPARAMETERS Get parameters of the procAdder "Adder" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    hasoslopes               HasoSlopes to set in the processor.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    comment                  Comments.
%                             
% 

if nargin ~= 3
	error('The "Imop_SlopesPostProcessorList_GetAdderParameters" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
comment = char(ones(256,1,'int8'));

[err_nb, err_message, comment] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetAdderParameters', err_message, SlopesPostProcessorList, position, comment, hasoslopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
