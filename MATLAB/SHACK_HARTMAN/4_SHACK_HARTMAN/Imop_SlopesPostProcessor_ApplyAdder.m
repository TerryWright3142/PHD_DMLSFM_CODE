function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyAdder(Slopes_in, Slopes_to_add, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYADDER Adds Slopes_to_add to the input slopes.
% 
%    Slopes_to_add  HasoSlopes to add.
%                   
%    Slopes_in      HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                   
%    Slopes_out     processed HasoSlopes object adress if not NULL.
%                   
%    err_message    Error message, empty if no error occured.
%                   
% 

if nargin < 2
	error('The "Imop_SlopesPostProcessor_ApplyAdder" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_SlopesPostProcessor_ApplyAdder" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyAdder', err_message, Slopes_in, Slopes_to_add, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
