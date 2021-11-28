function err_message = Imop_Camera_CallSpecificFeature(Camera, feature_name)

% IMOP_CAMERA_CALLSPECIFICFEATURE Perform a camera action regarding its name.
% 
%    Camera        Camera object adress.
%                  
%    feature_name  Name of the feature.
%                  
%    err_message   Error message, empty if no error occured.
%                  
% 

if nargin ~= 2
	error('The "Imop_Camera_CallSpecificFeature" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, feature_name] = calllib('WaveKitRuntime', 'Imop_Camera_CallSpecificFeature', err_message, Camera, feature_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
