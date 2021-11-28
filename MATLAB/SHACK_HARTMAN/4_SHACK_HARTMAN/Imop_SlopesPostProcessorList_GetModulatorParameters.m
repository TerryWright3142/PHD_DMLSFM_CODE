function [err_message, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation] = Imop_SlopesPostProcessorList_GetModulatorParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETMODULATORPARAMETERS Get parameters of the procModulator "Modulator" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    tiltx_modulation         Value of X tilt modulation.
%                             
%    tilty_modulation         Value of Y tilt modulation.
%                             
%    curv_modulation          Value of Curvature modulation.
%                             
%    astig0_modulation        Value of 0 degree astigmatism modulation.
%                             
%    astig45_modulation       Value of 45 degree astigmatism modulation.
%                             
%    others_modulation        Value of All other aberrations modulation.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetModulatorParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
tiltx_modulation = 0;
tilty_modulation = 0;
curv_modulation = 0;
astig0_modulation = 0;
astig45_modulation = 0;
others_modulation = 0;

[err_nb, err_message, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetModulatorParameters', err_message, SlopesPostProcessorList, position, tiltx_modulation, tilty_modulation, curv_modulation, astig0_modulation, astig45_modulation, others_modulation);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
