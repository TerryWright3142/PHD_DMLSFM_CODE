function err_message = Imop_CorrDataManager_UpdateInteractionMatrix(CorrDataManager, index, haso_slopes_push, haso_slopes_pull)

% IMOP_CORRDATAMANAGER_UPDATEINTERACTIONMATRIX Update interaction matrix from two HasoSlopes resulting of one calibration step for actuator index.
% 
%    CorrDataManager   CorrDataManager object adress.
%                      
%    index             Index of the actuator.
%                      
%    haso_slopes_push  HasoSlopes measured for the push movement of the actuator.
%                      
%    haso_slopes_pull  HasoSlopes measured for the pull movement of the actuator.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 4
	error('The "Imop_CorrDataManager_UpdateInteractionMatrix" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_UpdateInteractionMatrix', err_message, CorrDataManager, index, haso_slopes_push, haso_slopes_pull);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
