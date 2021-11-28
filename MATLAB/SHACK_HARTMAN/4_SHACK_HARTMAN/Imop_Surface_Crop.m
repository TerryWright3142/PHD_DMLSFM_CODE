function [err_message, crop] = Imop_Surface_Crop(surface, crop, cropCenter, cropSize)

% IMOP_SURFACE_CROP Crop surface
% 
%    surface      Surface object adress.
%                 
%    cropCenter   Crop center (relative to original surface coordinates system)
%                 
%    cropSize     Crop size
%                 
%    crop         Surface object.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 4
	error('The "Imop_Surface_Crop" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, cropCenter, cropSize] = calllib('WaveKitRuntime', 'Imop_Surface_Crop', err_message, surface, crop, cropCenter, cropSize);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
