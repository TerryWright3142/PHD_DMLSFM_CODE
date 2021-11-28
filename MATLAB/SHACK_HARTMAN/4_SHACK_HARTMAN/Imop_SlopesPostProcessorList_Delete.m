function err_message = Imop_SlopesPostProcessorList_Delete(SlopesPostProcessorList)

% IMOP_SLOPESPOSTPROCESSORLIST_DELETE SlopesPostProcessorList destructor
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 1
	error('The "Imop_SlopesPostProcessorList_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_Delete', err_message, SlopesPostProcessorList);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
