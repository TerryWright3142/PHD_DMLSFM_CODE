function [err_message, Phase] = Imop_Phase_NewFromModalCoef(ModalCoef, filter)

% IMOP_PHASE_NEWFROMMODALCOEF Phase constructor from Phase.
% This constructor computes the slopes on the input Phase object
%    depending on the projection type (Legendre or Zernike)
%    and number of coefficients,
%    then it computes the Phase and creates the corresponding Phase object.
%    The slopes computation and Phase reconstruction parameters (ComputePhaseSet)
%    are all set to their default values and cannot be modified.
%    Modal coeffs must have a projection pupil set in their preferences.
%    ModalCoef    ModalCoef object adress.
%                 
%    filter       Array of aberrations to filter.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Phase        Pointer to Phase object adress. Phase sampling sizes and steps are set from ModalCoef object (Pupil object sizes).
%                 
% 

if nargin ~= 2
	error('The "Imop_Phase_NewFromModalCoef" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
Phase = 0;

[err_nb, err_message, Phase, filter] = calllib('WaveKitRuntime', 'Imop_Phase_NewFromModalCoef', err_message, Phase, ModalCoef, filter);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
