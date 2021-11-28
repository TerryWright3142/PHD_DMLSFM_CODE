function err_message = Imop_CorrDataManager_ApplyPupilMask(corrdata_manager, pupil_mask)

% IMOP_CORRDATAMANAGER_APPLYPUPILMASK Modifies the greatest common pupil
% Sets the greatest common pupil to the intersection between itself and the pupil_mask.
%    If the pupil_mask has more "1" values than the current greatest common pupil, it won't have any effect on it (Reduce pupil size only).
%    corrdata_manager  CorrDataManager object adress.
%                      
%    pupil_mask        User-defined pupil mask as a pointer on a pupil object.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_ApplyPupilMask" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ApplyPupilMask', err_message, corrdata_manager, pupil_mask);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
