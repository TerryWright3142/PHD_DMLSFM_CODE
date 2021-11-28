function [err_message, dimensions, steps] = Imop_Phase_GetDimensionsAndSteps(Phase)

% IMOP_PHASE_GETDIMENSIONSANDSTEPS Get Phase dimensions
% 
%    Phase        Phase object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    dimensions   Phase dimensions as the (width, height) of the pupil.
%                 
%    steps        Phase sampling steps in x and y direction (um).
%                 
% 

if nargin ~= 1
	error('The "Imop_Phase_GetDimensionsAndSteps" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_Phase_GetDimensionsAndSteps', err_message, Phase, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
