function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyPerfectLens(Slopes_in, focal_lens_m, keep_residual_curvature, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYPERFECTLENS Adds the curvature of a perfect lens to the input slopes.
% 
%    focal_lens_m             Perfect lens focal length (m).
%                             
%    keep_residual_curvature  Keep the residual curvature.
%                             
%    Slopes_in                HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                             
%    Slopes_out               processed HasoSlopes object adress if not NULL.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin < 3
	error('The "Imop_SlopesPostProcessor_ApplyPerfectLens" function requires at least 3 input argument(s).');
elseif nargin > 4
	error('The "Imop_SlopesPostProcessor_ApplyPerfectLens" function cannot have more than 4 input argument(s).');
end
if nargin<=3
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyPerfectLens', err_message, Slopes_in, focal_lens_m, keep_residual_curvature, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
