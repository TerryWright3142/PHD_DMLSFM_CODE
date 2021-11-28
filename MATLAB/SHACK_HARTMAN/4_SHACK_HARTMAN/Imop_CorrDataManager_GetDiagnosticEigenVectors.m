function [err_message, HasoSlopes, commands] = Imop_CorrDataManager_GetDiagnosticEigenVectors(corrdata_manager, mode_index, HasoSlopes, commands)

% IMOP_CORRDATAMANAGER_GETDIAGNOSTICEIGENVECTORS Get HasoSlopes object and commands array associated to an influence.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    mode_index        Influence index.
%                      
%    HasoSlopes        HasoSlopes object adress.
%                      
%    commands          Command array .
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 4
	error('The "Imop_CorrDataManager_GetDiagnosticEigenVectors" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, commands] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetDiagnosticEigenVectors', err_message, corrdata_manager, mode_index, HasoSlopes, commands);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
