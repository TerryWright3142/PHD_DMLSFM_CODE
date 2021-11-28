function [err_message, HasoSlopes] = Imop_CorrDataManager_ComputeSlopesFromCommand(corrdata_manager, command, HasoSlopes)

% IMOP_CORRDATAMANAGER_COMPUTESLOPESFROMCOMMAND Simulation of the expected slopes given a wavefront corrector command.
% Function returns an error if command is not compliant with the current corrdata_manager wavefront corrector preferences.
%    corrdata_manager  CorrDataManager object adress.
%                      
%    command           Array of size actuators count, containing for each actuator its current position.
%                      
%    HasoSlopes        HasoSlopes object adress, where the simulated slopes are stored.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_ComputeSlopesFromCommand" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, command] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ComputeSlopesFromCommand', err_message, corrdata_manager, command, HasoSlopes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
