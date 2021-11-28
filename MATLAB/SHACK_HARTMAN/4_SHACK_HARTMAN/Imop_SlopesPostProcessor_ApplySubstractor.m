function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplySubstractor(Slopes_in, Slopes_to_sutract, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYSUBSTRACTOR Subtracts Slopes_to_sutract to the input slopes.
% 
%    Slopes_to_sutract  HasoSlopes to subtract.
%                       
%    Slopes_in          HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                       
%    Slopes_out         processed HasoSlopes object adress if not NULL.
%                       
%    err_message        Error message, empty if no error occured.
%                       
% 

if nargin < 2
	error('The "Imop_SlopesPostProcessor_ApplySubstractor" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_SlopesPostProcessor_ApplySubstractor" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplySubstractor', err_message, Slopes_in, Slopes_to_sutract, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
