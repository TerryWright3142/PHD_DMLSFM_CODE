function err_message = Imop_SlopesPostProcessorList_InsertShutOfBoundaries(SlopesPostProcessorList, position, shutoff_radius)

% IMOP_SLOPESPOSTPROCESSORLIST_INSERTSHUTOFBOUNDARIES Insert a procShutOfBoundaries "ShutOfBoundaries" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    shutoff_radius           Radius of the boundary neighbourood where sub-pupils must be shut off.
%                             
%    err_message              Error message, empty if no error occured.
%                             
% 

if nargin ~= 3
	error('The "Imop_SlopesPostProcessorList_InsertShutOfBoundaries" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_InsertShutOfBoundaries', err_message, SlopesPostProcessorList, position, shutoff_radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
