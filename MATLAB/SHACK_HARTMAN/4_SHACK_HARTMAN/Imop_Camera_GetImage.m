function [err_message, Image, RawImage] = Imop_Camera_GetImage(Camera, Image, remove_background, RawImage)

% IMOP_CAMERA_GETIMAGE Retrieve last captured image.
%    see Imop_Camera_AsyncImageReady
% 
%    Camera             Camera object adress.
%                       
%    remove_background  Boolean which indicates if background should be substracted.
%                       
%    Image              Captured image with (optionnally) background removed.
%                       
%    RawImage           Captured image without any post-processing applied.
%                       
%    err_message        Error message, empty if no error occured.
%                       
% 

if nargin < 2
	error('The "Imop_Camera_GetImage" function requires at least 2 input argument(s).');
elseif nargin > 4
	error('The "Imop_Camera_GetImage" function cannot have more than 4 input argument(s).');
end
if nargin<=3
	RawImage=0;
end
if nargin<=2
	remove_background=0;
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Camera_GetImage', err_message, Camera, Image, remove_background, RawImage);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
