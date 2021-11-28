function [err_message, focal_lens, keep_residual_curvature] = Imop_SlopesPostProcessorList_GetPerfectLensParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETPERFECTLENSPARAMETERS Get parameters of the procPerfectLens "PerfectLens" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    focal_lens               Lens focal length (m).
%                             
%    keep_residual_curvature  Keep the residual curvature.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetPerfectLensParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
focal_lens = 0;
keep_residual_curvature = 0;

[err_nb, err_message, focal_lens, keep_residual_curvature] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetPerfectLensParameters', err_message, SlopesPostProcessorList, position, focal_lens, keep_residual_curvature);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
