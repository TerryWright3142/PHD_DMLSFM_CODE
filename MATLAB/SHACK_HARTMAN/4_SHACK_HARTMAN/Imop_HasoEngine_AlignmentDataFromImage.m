function [err_message, barycentre] = Imop_HasoEngine_AlignmentDataFromImage(HasoEngine, image)

% IMOP_HASOENGINE_ALIGNMENTDATAFROMIMAGE During optical centering process, computes the barycenter coordinates in pixels of the visible spots on the Haso sensor.
%    The optical system is aligned when these coordinates are close to the alignment_position_pixels (error < tolerance_radius).
%    WARNING! The centering device must be mounted on the Haso sensor.
% 
%    HasoEngine   HasoEngine object adress.
%                 
%    image        Image object.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    barycentre   Barycenter coordinates.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoEngine_AlignmentDataFromImage" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
barycentre = [];

[err_nb, err_message, barycentre] = calllib('WaveKitRuntime', 'Imop_HasoEngine_AlignmentDataFromImage', err_message, HasoEngine, image, barycentre);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
