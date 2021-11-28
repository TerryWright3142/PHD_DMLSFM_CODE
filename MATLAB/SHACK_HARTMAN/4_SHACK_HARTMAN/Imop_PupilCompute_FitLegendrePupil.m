function [err_message, center, size] = Imop_PupilCompute_FitLegendrePupil(Pupil)

% IMOP_PUPILCOMPUTE_FITLEGENDREPUPIL Compute the geometric parameters of the Legendre pupil from a pupil input.
% This function is not parameterizable. It takes a user pupil as input and
%    detects a square pupil that is as large as possible and entirely inside it.
%    If several pupils with the same size suit, one of them is chosen arbitrarily.
%    Pupil        pupil object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    center       center coordinates.
%                 Values are expressed in subpupils.
%                 
%    size         dimensions (width, height) of the square pupil detected.
%                 Values are expressed in number of subpupils.
%                 
% 

if nargin ~= 1
	error('The "Imop_PupilCompute_FitLegendrePupil" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
center = [];
size = [];

[err_nb, err_message, center, size] = calllib('WaveKitRuntime', 'Imop_PupilCompute_FitLegendrePupil', err_message, Pupil, center, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
