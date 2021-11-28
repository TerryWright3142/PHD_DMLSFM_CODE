function [err_message, data] = Imop_CorrDataManager_GetCommandMatrixBuffer(corrdata_manager, data)

% IMOP_CORRDATAMANAGER_GETCOMMANDMATRIXBUFFER Command matrix content getter.
% 
%    corrdata_manager  CorrDataManager object adress.
%                      
%    data              2D Array of command matrix content.
%                      
%    err_message       Error message, empty if no error occured.
%                      
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_GetCommandMatrixBuffer" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, data] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetCommandMatrixBuffer', err_message, corrdata_manager, data);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
