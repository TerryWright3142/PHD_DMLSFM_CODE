function [err_message, shutoff_radius] = Imop_SlopesPostProcessorList_GetShutOfBoundariesParameters(SlopesPostProcessorList, position)

% IMOP_SLOPESPOSTPROCESSORLIST_GETSHUTOFBOUNDARIESPARAMETERS Get parameters of the procShutOfBoundaries "ShutOfBoundaries" processor.
% 
%    SlopesPostProcessorList  SlopesPostProcessorList object adress.
%                             
%    position                 Position of the processor in the SlopesPostProcessorList.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    shutoff_radius           Radius of the boundary neighbourood where sub-pupils must be shut off.
%                             
% 

if nargin ~= 2
	error('The "Imop_SlopesPostProcessorList_GetShutOfBoundariesParameters" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
shutoff_radius = 0;

[err_nb, err_message, shutoff_radius] = calllib('WaveKitRuntime', 'Imop_SlopesPostProcessorList_GetShutOfBoundariesParameters', err_message, SlopesPostProcessorList, position, shutoff_radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
