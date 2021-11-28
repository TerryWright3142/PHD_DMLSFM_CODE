function [err_message, dimensions, steps] = Imop_HasoData_GetDimensionsAndSteps(HasoData)

% IMOP_HASODATA_GETDIMENSIONSANDSTEPS Get HasoData dimensions and steps
% 
%    HasoData     HasoData object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    dimensions   HasoData dimensions as the (width, height) of the pupil.
%                 
%    steps        HasoData sampling steps in x and y direction (um).
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoData_GetDimensionsAndSteps" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
dimensions = [];
steps = [];

[err_nb, err_message, dimensions, steps] = calllib('WaveKitRuntime', 'Imop_HasoData_GetDimensionsAndSteps', err_message, HasoData, dimensions, steps);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
