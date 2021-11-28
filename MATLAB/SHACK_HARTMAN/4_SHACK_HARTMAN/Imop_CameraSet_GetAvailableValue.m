function [err_message, value] = Imop_CameraSet_GetAvailableValue(camera_set, parameter_name, index)

% IMOP_CAMERASET_GETAVAILABLEVALUE If parameter is a string to be selected among a finite set of strings,
%    extract the possible value located at the index position from this set.
%    see Imop_CameraSet_GetParameterOption.
% 
%    camera_set      CameraSet object adress.
%                    
%    parameter_name  Parameter name (must be the name of a parameter of type strings list).
%                    
%    index           Sub-parameter index.
%                    
%    err_message     Error message, empty if no error occured.
%                    
%    value           Value at index index.
%                    
% 

if nargin ~= 3
	error('The "Imop_CameraSet_GetAvailableValue" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
value = char(ones(256,1,'int8'));

[err_nb, err_message, parameter_name, value] = calllib('WaveKitRuntime', 'Imop_CameraSet_GetAvailableValue', err_message, camera_set, parameter_name, index, value);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
