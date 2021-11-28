function err_message = Imop_HasoEngine_SetShift(HasoEngine, shift)

% IMOP_HASOENGINE_SETSHIFT *Not available
% Set the shift values (in x and y direction) to apply to pair the start sub-pupil with the appropriate micro-lens.
%    HasoEngine   HasoEngine object adress.
%                 
%    shift        Alignment shift.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoEngine_SetShift" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, shift] = calllib('WaveKitRuntime', 'Imop_HasoEngine_SetShift', err_message, HasoEngine, shift);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
