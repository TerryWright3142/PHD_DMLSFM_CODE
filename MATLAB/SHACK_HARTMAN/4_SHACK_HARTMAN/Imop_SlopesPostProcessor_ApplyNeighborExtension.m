function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyNeighborExtension(Slopes_in, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYNEIGHBOREXTENSION Interpolates dark sub-pupils that are surrounded by light sub-pupils.
% 
%    Slopes_in    HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                 
%    Slopes_out   processed HasoSlopes object adress if not NULL.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin < 1
	error('The "Imop_SlopesPostProcessor_ApplyNeighborExtension" function requires at least 1 input argument(s).');
elseif nargin > 2
	error('The "Imop_SlopesPostProcessor_ApplyNeighborExtension" function cannot have more than 2 input argument(s).');
end
if nargin<=1
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyNeighborExtension', err_message, Slopes_in, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
