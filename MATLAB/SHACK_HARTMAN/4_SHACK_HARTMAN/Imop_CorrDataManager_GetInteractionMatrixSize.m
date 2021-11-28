function [err_message, size] = Imop_CorrDataManager_GetInteractionMatrixSize(corrdata_manager)

% IMOP_CORRDATAMANAGER_GETINTERACTIONMATRIXSIZE Interaction matrix size getter.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    size              Size of interaction matrix.
%                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_GetInteractionMatrixSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = [];

[err_nb, err_message, size] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetInteractionMatrixSize', err_message, corrdata_manager, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
