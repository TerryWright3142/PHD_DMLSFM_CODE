function [err_message, threshold] = Imop_SlopesPostProcessorList_GetPupilFromIntensityApplierParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETPUPILFROMINTENSITYAPPLIERPARAMETERS Get parameters of the procPupilFromIntensityApplier "PupilFromIntensityApplier" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    threshold                Intensity thresholding level.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetPupilFromIntensityApplierParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
threshold = 0;

[err_nb, err_message, threshold] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetPupilFromIntensityApplierParameters', err_message, SlopesPostProcessorList, position, threshold);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
