function [err_message, DoublePathActivateOnTilt, DoublePathActivateOnCurvature] = Imop_SlopesPostProcessorList_GetDoublePathParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETDOUBLEPATHPARAMETERS Get parameters of the procDoublePath "DoublePath" processor.
% 
%    SlopesPostProcessorList        SlopesPostProcessorList object adress.
%                                   
%    position                       Position of the processor in the SlopesPostProcessorList.
%                                   
%    err_message                    Error message, empty if no error occured.
%                                   
%    DoublePathActivateOnTilt       State of Double path activation on tilt.
%                                   
%    DoublePathActivateOnCurvature  State of Double path activation on curvature.
%                                   
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetDoublePathParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
DoublePathActivateOnTilt = 0;
DoublePathActivateOnCurvature = 0;

[err_nb, err_message, DoublePathActivateOnTilt, DoublePathActivateOnCurvature] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetDoublePathParameters', err_message, SlopesPostProcessorList, position, DoublePathActivateOnTilt, DoublePathActivateOnCurvature);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
