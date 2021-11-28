function err_message = Imop_HasoData_ApplySlopesPostProcessorList(HasoData, SlopesPostProcessorList)

% IMOP_HASODATA_APPLYSLOPESPOSTPROCESSORLIST Apply a SlopesPostProcessorList to the raw HasoSlopes stores in the HasoData object.
% 
%    HasoData                 HasoData object adress.
%                             
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 2
	error('The "Imop_HasoData_ApplySlopesPostProcessorList" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoData_ApplySlopesPostProcessorList', err_message, HasoData, SlopesPostProcessorList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
