function [err_message, start_subpupil, denoising_strength] = Imop_HasoEngine_GetPreferences(HasoEngine)

% IMOP_HASOENGINE_GETPREFERENCES HasoSlopes computation parameters getter.
% 
%    HasoEngine          HasoEngine object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    start_subpupil      Coordinates of the first calculated sub-pupil (index coordinates relative to the top-left corner of the pupil).
%                        
%    denoising_strength  Sensitivity of spot detection on summed images (between 0 and 1).
%                        
% 

if nargin ~= 1
	error('The "Imop_HasoEngine_GetPreferences" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
start_subpupil = [];
denoising_strength = 0;

[err_nb, err_message, start_subpupil, denoising_strength] = calllib('WaveKitRuntime', 'Imop_HasoEngine_GetPreferences', err_message, HasoEngine, start_subpupil, denoising_strength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
