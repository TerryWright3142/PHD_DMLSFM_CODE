function err_message = Imop_CorrDataManager_ResetInteractionMatrix(corrdata_manager)

% IMOP_CORRDATAMANAGER_RESETINTERACTIONMATRIX Reset Interaction matrix, greatest common pupil and Wavefront corrector preferences to the last stable state.
%    WARNING! This function clears command matrix and diagnostics.
% Restore the CorrDataManager to last interaction matrix computation state or last loading from a backup file.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_ResetInteractionMatrix" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ResetInteractionMatrix', err_message, corrdata_manager);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
