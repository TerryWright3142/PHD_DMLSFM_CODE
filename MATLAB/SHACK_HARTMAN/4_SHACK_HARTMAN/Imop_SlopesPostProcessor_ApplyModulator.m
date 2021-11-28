function [err_message, Slopes_in, Slopes_out] = Imop_SlopesPostProcessor_ApplyModulator(Slopes_in, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation, Slopes_out)

% IMOP_SLOPESPOSTPROCESSOR_APPLYMODULATOR Modulates (multiply by a real factor between 0 and 1) some HasoSlopes aberrations.
% 
%    tiltx_modulation    Value of x tilt modulation between 0 and 1.
%                        
%    tilty_modulation    Value of y tilt modulation between 0 and 1.
%                        
%    curv_modulation     Value of curvature modulation between 0 and 1.
%                        
%    astig0_modulation   Value of 0 degree astigmatism modulation between 0 and 1.
%                        
%    astig45_modulation  Value of 45 degree astigmatism modulation between 0 and 1.
%                        
%    others_modulation   Value of all other aberrations modulation between 0 and 1.
%                        
%    Slopes_in           HasoSlopes object adress, modified by the processor if Slopes_out = NULL.
%                        
%    Slopes_out          processed HasoSlopes object adress if not NULL.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin < 7
	error('The "Imop_SlopesPostProcessor_ApplyModulator" function requires at least 7 input argument(s).');
elseif nargin > 8
	error('The "Imop_SlopesPostProcessor_ApplyModulator" function cannot have more than 8 input argument(s).');
end
if nargin<=7
	Slopes_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessor_ApplyModulator', err_message, Slopes_in, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation, Slopes_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
