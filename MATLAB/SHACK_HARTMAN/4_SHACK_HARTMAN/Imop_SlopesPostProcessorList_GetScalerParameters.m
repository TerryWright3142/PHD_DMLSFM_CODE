function [err_message, comment, scale_factor] = Imop_SlopesPostProcessorList_GetScalerParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETSCALERPARAMETERS Get parameters of the procScaler "Scaler" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    comment                  Comments.
%                             
%    scale_factor             Scale factor.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetScalerParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
comment = char(ones(256,1,'int8'));
scale_factor = 0;

[err_nb, err_message, comment, scale_factor] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetScalerParameters', err_message, SlopesPostProcessorList, position, comment, scale_factor);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
