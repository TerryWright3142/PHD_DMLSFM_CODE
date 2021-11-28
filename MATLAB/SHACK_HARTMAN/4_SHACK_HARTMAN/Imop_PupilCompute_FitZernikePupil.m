function [err_message, center, radius] = Imop_PupilCompute_FitZernikePupil(Pupil, detection_mode, covering, has_central_occultation)

% IMOP_PUPILCOMPUTE_FITZERNIKEPUPIL Compute the geometric parameters of the Zernike pupil from a pupil input.
% 
%    Pupil                    pupil object adress.
%                             
%    detection_mode           E_PUPIL_DETECTION_T circular pupil detection mode.
%                             
%    covering                 E_PUPIL_COVERING_T circular pupil covering mode.
%                             
%    has_central_occultation  If pupil has a central occultation, this boolean must be set to true
%                             to tell the circular pupil detector that internal sub-pupils are missing.
%                             
%    err_message              Error message, empty if no error occured.
%                             
%    center                   User pupil center coordinates if detection mode = E_PUPIL_FIXED_CENTER.
%                             Value is ignore for other detection modes.
%                             Values are expressed in number of subpupils.
%                             
%    radius                   User pupil radius if detection mode = E_PUPIL_FIXED_RADIUS.
%                             Value is ignore for other detection modes.
%                             Value is expressed in number of subpupils.
%                             
% 

if nargin ~= 4
	error('The "Imop_PupilCompute_FitZernikePupil" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
center = [];
radius = 0;

[err_nb, err_message, center, radius] = calllib('WaveKitRuntime', 'Imop_PupilCompute_FitZernikePupil', err_message, Pupil, detection_mode, covering, has_central_occultation, center, radius);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
