function [err_message, shift] = Imop_HasoEngine_GetShift(HasoEngine)

% IMOP_HASOENGINE_GETSHIFT Get the shift values (in x and y direction) to apply to pair the start sub-pupil with the appropriate micro-lens.
% 
%    HasoEngine   HasoEngine object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    shift        Alignment shift.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoEngine_GetShift" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
shift = [];

[err_nb, err_message, shift] = calllib('WaveKitRuntime', 'Imop_HasoEngine_GetShift', err_message, HasoEngine, shift);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
