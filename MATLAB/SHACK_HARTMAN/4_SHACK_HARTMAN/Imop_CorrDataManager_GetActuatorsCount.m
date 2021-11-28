function [err_message, actuators_count] = Imop_CorrDataManager_GetActuatorsCount(corrdata_manager)

% IMOP_CORRDATAMANAGER_GETACTUATORSCOUNT Wavefront corrector actuators number getter.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    actuators_count   WavefrontCorrector actuators count.
%                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_GetActuatorsCount" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
actuators_count = 0;

[err_nb, err_message, actuators_count] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetActuatorsCount', err_message, corrdata_manager, actuators_count);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
