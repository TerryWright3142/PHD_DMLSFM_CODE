function err_message = Imop_SlopesPostProcessorList_InsertPupilFromIntensityApplier(SlopesPostProcessorList, position, threshold)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTPUPILFROMINTENSITYAPPLIER Insert a procPupilFromIntensityApplier "PupilFromIntensityApplier" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    threshold                Intensity thresholding level.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 3
	error('The "Imop_SlopesPostProcessorList_InsertPupilFromIntensityApplier" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertPupilFromIntensityApplier', err_message, SlopesPostProcessorList, position, threshold);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
