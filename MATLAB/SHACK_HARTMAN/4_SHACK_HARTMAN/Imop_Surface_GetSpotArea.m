function [err_message, SpotArea, spotAreaCenter, spotAreaMax] = Imop_Surface_GetSpotArea(Surface, SpotArea, enlargement, smoothing)

% IMOP_SURFACE_GETSPOTAREA Get spot area.
% 
%    Surface         Surface object adress.
%                    
%    enlargement     Multiplicative factor to apply to the width and height of the spot bounding box for cropping
%                    
%    smoothing       Projection smoothing size as a percentage of projection length
%                    
%    SpotArea        Surface object.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    spotAreaCenter  Spot area center (relative to original surface coordinates system)
%                    
%    spotAreaMax     Spot maximum location (relative to original surface coordinates system)
%                    
% 

if nargin < 2
	error('The "Imop_Surface_GetSpotArea" function requires at least 2 input argument(s).');
elseif nargin > 4
	error('The "Imop_Surface_GetSpotArea" function cannot have more than 4 input argument(s).');
end
if nargin<=3
	smoothing=10;
end
if nargin<=2
	enlargement=5;
end
err_message = char(ones(256,1,'int8'));
spotAreaCenter = [];
spotAreaMax = [];

[err_nb, err_message, spotAreaCenter, spotAreaMax] = calllib('WaveKitRuntime', 'Imop_Surface_GetSpotArea', err_message, Surface, SpotArea, spotAreaCenter, spotAreaMax, enlargement, smoothing);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
