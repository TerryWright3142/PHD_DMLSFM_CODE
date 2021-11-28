function err_message = Imop_SlopesPostProcessorList_InsertFilter(SlopesPostProcessorList, position, apply_tiltx_filter, apply_tilty_filter, apply_curv_filter, apply_astig0_filter, apply_astig45_filter, apply_others_filter)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTFILTER Insert a procFilter "Filter" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    apply_tiltx_filter       Activate x tilt filter.
%                             
%    apply_tilty_filter       Activate y tilt filter.
%                             
%    apply_curv_filter        Activate curvature filter.
%                             
%    apply_astig0_filter      Activate 0 degree astigmatism filter.
%                             
%    apply_astig45_filter     Activate 45 degree astigmatism filter.
%                             
%    apply_others_filter      Activate all other aberrations filter.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 8
	error('The "Imop_SlopesPostProcessorList_InsertFilter" function requires 8 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertFilter', err_message, SlopesPostProcessorList, position, apply_tiltx_filter, apply_tilty_filter, apply_curv_filter, apply_astig0_filter, apply_astig45_filter, apply_others_filter);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
