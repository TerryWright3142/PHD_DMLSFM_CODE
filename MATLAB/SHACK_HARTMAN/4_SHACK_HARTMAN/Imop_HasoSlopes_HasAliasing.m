function [err_message, aliasing] = Imop_HasoSlopes_HasAliasing(HasoSlopes, radius_of_curvature)

% IMOP_HASOSLOPES_HASALIASING Test whether HasoSlopes causes aliasing
% When Phase has been reconstructed from slopes, strong local extrema on slopes
%    may provoke aliasing.
%    This function allows to test whether slopes will
%    produce suitable phase for correct gaussian parameters computation. Source
%    wavelength must be available in metadata of input Haso slopes. The radius of
%    curvature of the slopes, in millimeters, is required to perform the test.
%    HasoSlopes           HasoSlopes object adress.
%                         
%    radius_of_curvature  radius of curvature of the slopes (mm).
%                         
%    err_message          Error message, empty if no error occured.
%                         
%    aliasing             has aliasing (value 0 or 1).
%                         
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_HasAliasing" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
aliasing = 0;

[err_nb, err_message, aliasing] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_HasAliasing', err_message, HasoSlopes, radius_of_curvature, aliasing);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
