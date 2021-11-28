function Imop_Camera_IsHasoSensor()

% IMOP_CAMERA_ISHASOSENSOR Get Camera dimensions and depth.
% 
% 

if nargin ~= 0
	error('The "Imop_Camera_IsHasoSensor" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Camera_IsHasoSensor');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
