function [err_message, feature_name] = Imop_CameraSet_GetSpecificFeatureName(camera_set, index)

% IMOP_CAMERASET_GETSPECIFICFEATURENAME Camera features name getter given its position in the parameters list.
% 
%    camera_set    CameraSet object adress.
%                  
%    index         Feature index.
%                  
%    err_message   Error message, empty if no error occured.
%                  
%    feature_name  Feature name.
%                  
% 

if nargin ~= 2
	error('The "Imop_CameraSet_GetSpecificFeatureName" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
feature_name = char(ones(256,1,'int8'));

[err_nb, err_message, feature_name] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetSpecificFeatureName', err_message, camera_set, index, feature_name);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
