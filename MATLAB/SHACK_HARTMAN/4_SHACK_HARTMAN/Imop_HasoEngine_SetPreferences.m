function err_message = Imop_HasoEngine_SetPreferences(HasoEngine, start_subpupil, denoising_strength)

% IMOP_HASOENGINE_SETPREFERENCES HasoSlopes computation parameters setter.
% 
%    HasoEngine          HasoEngine object adress.
%                        
%    start_subpupil      Coordinates of the first calculated sub-pupil (index coordinates relative to the top-left corner of the pupil).
%                        
%    denoising_strength  Sensitivity of spot detection on summed images (between 0 and 1).
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 3
	error('The "Imop_HasoEngine_SetPreferences" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, start_subpupil] = calllib('WaveKitRuntime', 'Imop_HasoEngine_SetPreferences', err_message, HasoEngine, start_subpupil, denoising_strength);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
