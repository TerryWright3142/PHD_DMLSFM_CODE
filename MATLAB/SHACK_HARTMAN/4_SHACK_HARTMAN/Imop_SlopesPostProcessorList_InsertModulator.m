function err_message = Imop_SlopesPostProcessorList_InsertModulator(SlopesPostProcessorList, position, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTMODULATOR Insert a procModulator "Modulator" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    tiltx_modulation         Value of x tilt modulation between 0 and 1.
%                             
%    tilty_modulation         Value of y tilt modulation between 0 and 1.
%                             
%    curv_modulation          Value of curvature modulation between 0 and 1.
%                             
%    astig0_modulation        Value of 0 degree astigmatism modulation between 0 and 1.
%                             
%    astig45_modulation       Value of 45 degree astigmatism modulation between 0 and 1.
%                             
%    others_modulation        Value of all other aberrations modulation between 0 and 1.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 8
	error('The "Imop_SlopesPostProcessorList_InsertModulator" function requires 8 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertModulator', err_message, SlopesPostProcessorList, position, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
