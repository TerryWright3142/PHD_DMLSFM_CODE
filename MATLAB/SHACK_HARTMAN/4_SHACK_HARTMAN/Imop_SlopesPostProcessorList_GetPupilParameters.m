function [err_message, pupil_file_path, Pupil] = Imop_SlopesPostProcessorList_GetPupilParameters(SlopesPostProcessorList, position, Pupil)

% IMOP_SLOPESPOSTPROCESSORLIST_GETPUPILPARAMETERS Get parameters of the procPupil "Pupil" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    Pupil                    pupil object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    pupil_file_path          Pupil file path. No check is performed to assert that the Pupil parameter matches the pupil stored in pupil_file_path.
%                             
% 

if nargin ~= 3
	error('The "Imop_SlopesPostProcessorList_GetPupilParameters" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
pupil_file_path = char(ones(256,1,'int8'));

[err_nb, err_message, pupil_file_path] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetPupilParameters', err_message, SlopesPostProcessorList, position, pupil_file_path, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
