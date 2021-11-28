function [err_message, is_tiltx_filter_on, is_tilty_filter_on, is_curv_filter_on, is_astig0_filter_on, is_astig45_filter_on, is_others_filter_on] = Imop_SlopesPostProcessorList_GetFilterParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETFILTERPARAMETERS Get parameters of the procFilter "Filter" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    is_tiltx_filter_on       X tilt filter state.
%                             
%    is_tilty_filter_on       Y tilt filter state.
%                             
%    is_curv_filter_on        Curvature filter state.
%                             
%    is_astig0_filter_on      0 degree astigmatism filter state.
%                             
%    is_astig45_filter_on     45 degree astigmatism filter state.
%                             
%    is_others_filter_on      All other aberrations filter state.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetFilterParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
is_tiltx_filter_on = 0;
is_tilty_filter_on = 0;
is_curv_filter_on = 0;
is_astig0_filter_on = 0;
is_astig45_filter_on = 0;
is_others_filter_on = 0;

[err_nb, err_message, is_tiltx_filter_on, is_tilty_filter_on, is_curv_filter_on, is_astig0_filter_on, is_astig45_filter_on, is_others_filter_on] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetFilterParameters', err_message, SlopesPostProcessorList, position, is_tiltx_filter_on, is_tilty_filter_on, is_curv_filter_on, is_astig0_filter_on, is_astig45_filter_on, is_others_filter_on);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
