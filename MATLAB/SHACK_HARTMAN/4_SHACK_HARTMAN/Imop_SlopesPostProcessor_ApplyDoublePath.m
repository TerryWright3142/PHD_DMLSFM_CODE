function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyDoublePath(Slopes_in, is_doublePath_active_on_tilt, is_doublePath_active_on_curv, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYDOUBLEPATH Divides the HasoSlopes by two.May ignore tilt and / or curvature depending on parametrization.
% 
%    is_doublePath_active_on_tilt  Is Double path active on tilt.
%                                  
%    is_doublePath_active_on_curv  Is Double path is active on curvature.
%                                  
%    Slopes_in                     HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                                  
%    Slopes_out                    processed HasoSlopes object adress if not NULL.
%                                  
%    err_message                   Error message, empty if no error occured.
%                                  
% 

if nargin < 3
	error('The "Imop_SlopesPostProcessor_ApplyDoublePath" function requires at least 3 input argument(s).');
elseif nargin > 4
	error('The "Imop_SlopesPostProcessor_ApplyDoublePath" function cannot have more than 4 input argument(s).');
end
if nargin<=3
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyDoublePath', err_message, Slopes_in, is_doublePath_active_on_tilt, is_doublePath_active_on_curv, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
