function [err_message, size] = Imop_CameraSet_GetParametersListSize(camera_set)

% IMOP_CAMERASET_GETPARAMETERSLISTSIZE Camera parameters list size getter.
% 
%    camera_set   CameraSet object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    size         Parameters list size (total count of camera parameters).
%                 
% 

if nargin ~= 1
	error('The "Imop_CameraSet_GetParametersListSize" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
size = 0;

[err_nb, err_message, size] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetParametersListSize', err_message, camera_set, size);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
