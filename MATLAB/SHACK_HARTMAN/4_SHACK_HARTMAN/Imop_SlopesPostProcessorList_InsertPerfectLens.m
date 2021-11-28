function err_message = Imop_SlopesPostProcessorList_InsertPerfectLens(SlopesPostProcessorList, position, focal_lens, keep_residual_curvature)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTPERFECTLENS Insert a procPerfectLens "PerfectLens" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    focal_lens               Perfect lens focal length (m).
%                             
%    keep_residual_curvature  Keep the residual curvature.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertPerfectLens" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertPerfectLens', err_message, SlopesPostProcessorList, position, focal_lens, keep_residual_curvature);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
