function [err_message, Pupil_in, Pupil_out] = Imop_PupilCompute_ApplyNeighborExtension(Pupil_in, Pupil_out)

% IMOP_PUPILCOMPUTE_APPLYNEIGHBOREXTENSION Applies a "NeighborExtension" (Fill) to a Pupil object.
% 
%    Pupil_in     Pupil object adress, modified by the operation if Pupil_out = NULL.
%                 
%    Pupil_out    processed Pupil object adress if not NULL.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin < 1
	error('The "Imop_PupilCompute_ApplyNeighborExtension" function requires at least 1 input argument(s).');
elseif nargin > 2
	error('The "Imop_PupilCompute_ApplyNeighborExtension" function cannot have more than 2 input argument(s).');
end
if nargin<=1
	Pupil_out=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_PupilCompute_ApplyNeighborExtension', err_message, Pupil_in, Pupil_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
