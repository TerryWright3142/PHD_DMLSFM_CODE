function [err_message, Pupil_out] = Imop_PupilCompute_FillOccultations(Pupil_in)

% IMOP_PUPILCOMPUTE_FILLOCCULTATIONS Compute a pupil with no holes in it (for example, central occultation case).
% If pupil_in is
%    0 0 0 0 0
%    0 1 1 1 0
%    1 1 0 1 1
%    0 1 1 1 0
%    0 0 0 0 0
%    pupil_out will be
%    0 0 0 0 0
%    0 1 1 1 0
%    1 1 1 1 1
%    0 1 1 1 0
%    0 0 0 0 0
%    The difference with Imop_PupilCompute_ApplyNeighborExtension is that there is no constraint on the occultations size.
%    Pupil_in     pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Pupil_out    pupil object adress.
%                 
% 

if nargin ~= 1
	error('The "Imop_PupilCompute_FillOccultations" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Pupil_out = 0;

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_PupilCompute_FillOccultations', err_message, Pupil_in, Pupil_out);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
