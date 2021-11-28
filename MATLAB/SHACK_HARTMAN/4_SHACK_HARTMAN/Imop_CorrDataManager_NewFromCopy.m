function [err_message, corrdata_manager] = Imop_CorrDataManager_NewFromCopy(corrdata_manager_src)

% IMOP_CORRDATAMANAGER_NEWFROMCOPY CorrDataManager copy constructor.
% 
%    corrdata_manager_src  Adress of the CorrDataManager object to be copied.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    corrdata_manager      Pointer to CorrDataManager object adress.
%                          
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_NewFromCopy" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
corrdata_manager = 0;

[err_nb, err_message, corrdata_manager] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_NewFromCopy', err_message, corrdata_manager_src, corrdata_manager);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
