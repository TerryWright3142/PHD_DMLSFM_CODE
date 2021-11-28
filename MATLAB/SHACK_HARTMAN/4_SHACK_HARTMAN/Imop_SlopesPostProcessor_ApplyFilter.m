function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyFilter(Slopes_in, apply_tiltx_filter, apply_tilty_filter, apply_curv_filter, apply_astig0_filter, apply_astig45_filter, apply_others_filter, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYFILTER Filters (remove) some HasoSlopes aberrations.
% 
%    apply_tiltx_filter    Activate x tilt removal.
%                          
%    apply_tilty_filter    Activate y tilt removal.
%                          
%    apply_curv_filter     Activate curvature removal.
%                          
%    apply_astig0_filter   Activate 0 degree astigmatism removal.
%                          
%    apply_astig45_filter  Activate 45 degree astigmatism removal.
%                          
%    apply_others_filter   Activate all other aberrations removal.
%                          
%    Slopes_in             HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                          
%    Slopes_out            processed HasoSlopes object adress if not NULL.
%                          
%    err_message           Error message, empty if no error occured.
%                          
% 

if nargin < 7
	error('The "Imop_SlopesPostProcessor_ApplyFilter" function requires at least 7 input argument(s).');
elseif nargin > 8
	error('The "Imop_SlopesPostProcessor_ApplyFilter" function cannot have more than 8 input argument(s).');
end
if nargin<=7
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyFilter', err_message, Slopes_in, apply_tiltx_filter, apply_tilty_filter, apply_curv_filter, apply_astig0_filter, apply_astig45_filter, apply_others_filter, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
