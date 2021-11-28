function [err_message, pupil] = Imop_CorrDataManager_GetGreatestCommonPupil(corrdata_manager, pupil)

% IMOP_CORRDATAMANAGER_GETGREATESTCOMMONPUPIL Computes the greatest common pupil
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    pupil             Greatest common pupil as a 2D Array
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_GetGreatestCommonPupil" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, pupil] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetGreatestCommonPupil', err_message, corrdata_manager, pupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
