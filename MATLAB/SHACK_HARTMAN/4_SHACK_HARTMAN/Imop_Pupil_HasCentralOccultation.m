function [err_message, has_holes] = Imop_Pupil_HasCentralOccultation(Pupil)

% IMOP_PUPIL_HASCENTRALOCCULTATION Find if pupil has one or more central occultation(s).
% 
%    Pupil        Pupil object adress.
%                 
%    err_message  Error message, empty if no error occured
%                 
%    has_holes    True if Pupil has one or more central occultation(s).
%                 
% 

if nargin ~= 1
	error('The "Imop_Pupil_HasCentralOccultation" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
has_holes = 0;

[err_nb, err_message, has_holes] = calllib('WaveKitRuntime', 'Imop_Pupil_HasCentralOccultation', err_message, Pupil, has_holes);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
