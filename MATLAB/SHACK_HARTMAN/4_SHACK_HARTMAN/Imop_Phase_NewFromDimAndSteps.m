function [err_message, Phase] = Imop_Phase_NewFromDimAndSteps(dimensions, step)

% IMOP_PHASE_NEWFROMDIMANDSTEPS Phase constructor from dimensions and steps.
% All the elements of the Phase values buffer are set to zero and the elements
%    of the pupil are set to true.
%    dimensions   Phase dimensions as the (width, height) of the pupil.
%                 
%    step         Phase sampling steps in x and y direction (um).
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Phase        Pointer to Phase object adress.
%                 
% 

if nargin ~= 2
	error('The "Imop_Phase_NewFromDimAndSteps" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Phase = 0;

[err_nb, err_message, dimensions, step, Phase] = calllib('WaveKitRuntime', 'Imop_Phase_NewFromDimAndSteps', err_message, dimensions, step, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
