function err_message = Imop_SlopesPostProcessorList_InsertDoublePath(SlopesPostProcessorList, position, is_doublePath_active_on_tilt, is_doublePath_active_on_curv)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTDOUBLEPATH Insert a procDoublePath "DoublePath" processor.
% 
%    SlopesPostProcessorList       SlopesPostProcessorList object adress.
%                                  
%    position                      Position of the processor in the SlopesPostProcessorList.
%                                  
%    is_doublePath_active_on_tilt  Is Double path active on tilt.
%                                  
%    is_doublePath_active_on_curv  Is Double path is active on curvature.
%                                  
%    err_message                   Error message, empty if no error occured.
%                                  
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertDoublePath" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertDoublePath', err_message, SlopesPostProcessorList, position, is_doublePath_active_on_tilt, is_doublePath_active_on_curv);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
