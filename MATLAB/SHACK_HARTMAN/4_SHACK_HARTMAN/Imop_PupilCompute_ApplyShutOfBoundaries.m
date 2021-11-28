function [err_message, Pupil_in, Pupil_out] = Imop_PupilCompute_ApplyShutOfBoundaries(Pupil_in, shutoff_radius, Pupil_out)

% IMOP_PUPILCOMPUTE_APPLYSHUTOFBOUNDARIES Applies a "ShutOfBoundaries" (Erosion) to a Pupil object.
% 
%    shutoff_radius  Radius of the boundary neighbourood where sub-pupils must be shut off.
%                    
%    Pupil_in        Pupil object adress, modified by the operation if Pupil_out = NULL.
%                    
%    Pupil_out       processed Pupil object adress if not NULL.
%                    
%    err_message     Error message, empty if no error occured.
%                    
% 

if nargin < 2
	error('The "Imop_PupilCompute_ApplyShutOfBoundaries" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_PupilCompute_ApplyShutOfBoundaries" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	Pupil_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_PupilCompute_ApplyShutOfBoundaries', err_message, Pupil_in, shutoff_radius, Pupil_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
