function err_message = Imop_SlopesPostProcessorList_InsertScaler(SlopesPostProcessorList, position, comment, scale_factor)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTSCALER Insert a procScaler "Scaler" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    comment                  Comments.
%                             
%    scale_factor             Scale factor.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 4
	error('The "Imop_SlopesPostProcessorList_InsertScaler" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, comment] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertScaler', err_message, SlopesPostProcessorList, position, comment, scale_factor);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
