function [err_message, delta_command] = Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes(corrdata_manager, delta_slopes, delta_command)

% IMOP_CORRDATAMANAGER_COMPUTEDELTACOMMANDFROMDELTASLOPES Compute the relative wavefront corrector commands corresponding to a delta_slopes variation.
% This function uses the CorrDataManager command matrix and wavefront corrector preferences to compute the output command.
%    Typical application is to compute the delta slopes as the difference between the current measured slopes
%    and references slopes (for example, references slopes can be created from a particular set of Zernike coefficients,
%    see Imop_HasoSlopes_NewFromModalCoef).
%    corrdata_manager  CorrDataManager object adress.
%                      
%    delta_slopes      Array of target slopes deltas (stored as HasoSlopes).
%                      
%    delta_command     Array of size actuators count, containing the commands deltas (relatives variations to apply from actuators initial positions).
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, delta_command] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes', err_message, corrdata_manager, delta_slopes, delta_command);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
