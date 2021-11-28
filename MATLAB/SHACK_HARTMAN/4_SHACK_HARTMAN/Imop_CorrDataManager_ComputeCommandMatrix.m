function err_message = Imop_CorrDataManager_ComputeCommandMatrix(corrdata_manager)

% IMOP_CORRDATAMANAGER_COMPUTECOMMANDMATRIX Computes command matrix.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_ComputeCommandMatrix" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ComputeCommandMatrix', err_message, corrdata_manager);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
