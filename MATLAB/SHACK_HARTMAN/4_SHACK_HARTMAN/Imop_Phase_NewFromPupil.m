function [err_message, Phase] = Imop_Phase_NewFromPupil(Pupil, default_value)

% IMOP_PHASE_NEWFROMPUPIL Phase constructor from pupil
% 
%    Pupil          pupil object adress.
%                   
%    default_value  Phase default value.
%                   
%    err_message    Error message, empty if no error occured.
%                   
%    Phase          Pointer to Phase object adress. Phase size and step are set from Pupil object.
%                   
% 

if nargin ~= 2
	error('The "Imop_Phase_NewFromPupil" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Phase = 0;

[err_nb, err_message, Phase] = calllib('WaveKitRuntime', 'Imop_Phase_NewFromPupil', err_message, Pupil, default_value, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
