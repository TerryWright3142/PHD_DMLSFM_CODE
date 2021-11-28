function [err_message, singular_vector] = Imop_CorrDataManager_GetDiagnosticSingularVector(corrdata_manager, singular_vector)

% IMOP_CORRDATAMANAGER_GETDIAGNOSTICSINGULARVECTOR Get vector of singular values.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    singular_vector   Array of influences, sorted in descending order.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_GetDiagnosticSingularVector" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, singular_vector] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetDiagnosticSingularVector', err_message, corrdata_manager, singular_vector);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
