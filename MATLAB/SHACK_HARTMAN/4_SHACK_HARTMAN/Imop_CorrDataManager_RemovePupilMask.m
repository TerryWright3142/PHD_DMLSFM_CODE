function err_message = Imop_CorrDataManager_RemovePupilMask(corrdata_manager)

% IMOP_CORRDATAMANAGER_REMOVEPUPILMASK Restore the greatest common pupil
% Cancel the effects of pupil mask(s) : Restore the greatest common pupil to last interaction matrix computation value or last loading from a backup value.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_RemovePupilMask" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_RemovePupilMask', err_message, corrdata_manager);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
