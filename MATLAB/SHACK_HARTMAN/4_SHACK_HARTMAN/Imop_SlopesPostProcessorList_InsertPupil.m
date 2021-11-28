function err_message = Imop_SlopesPostProcessorList_InsertPupil(SlopesPostProcessorList, position, pupil_file_path, Pupil)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTPUPIL Insert a procPupil "Pupil" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    pupil_file_path          Pupil file path. No check is performed to assert that the Pupil parameter matches the pupil stored in pupil_file_path.
%                             
%    Pupil                    pupil object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertPupil" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, pupil_file_path] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertPupil', err_message, SlopesPostProcessorList, position, pupil_file_path, Pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
