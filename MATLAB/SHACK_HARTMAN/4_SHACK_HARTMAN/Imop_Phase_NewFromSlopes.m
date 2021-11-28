function [err_message, Phase] = Imop_Phase_NewFromSlopes(HasoSlopes, m_type, filter, nb_coeffs)

% IMOP_PHASE_NEWFROMSLOPES Phase constructor from HasoSlopes.
%    This constructor computes the Phase using the selected method :
%    1 = Modal reconstruction, Legendre basis
%    2 = Modal reconstruction, Zernike basis
%    3 = Zonal reconstruction
%    and creates the corresponding Phase object.
%    The Phase reconstruction parameters (ComputePhaseSet) are all set to their default values
%    and cannot be modified, except the aberration filter (0 = aberration is removed) and
%    the number of coefficients to be used for modal reconstructions (before filtering).
%    The correspondance between aberrations and polynomial modes (Modal reconstructions only) is
%    automatically computed.
%    - filter[0] : tiltx
%    - filter[1] : tilty
%    - filter[2] : curvature
%    - filter[3] : astigmatism 0 degree
%    - filter[4] : astigmatism 45 degree
%    The projection pupil (Modal reconstructions only) is automatically computed from the slopes natural pupil.
% 
%    HasoSlopes   HasoSlopes object adress.
%                 
%    m_type       E_COMPUTEPHASESET_T Phase reconstruction mode (Modal Legendre, Modal Zernike or Zonal only)
%                 
%    filter       Array of aberrations to filter
%                 Filter must be a 5 elements array
%                 
%    nb_coeffs    Optional number of coefficients to use for reconstruction.
%                 This parameters is mandatory if case Phase reconstruction mode is Modal Legendre or Modal Zernike,
%                 This parameters is ignored in reconstruction mode Zonal.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    Phase        Pointer to Phase object adress. Phase sampling steps unit is um.
%                 
% 

if nargin < 3
	error('The "Imop_Phase_NewFromSlopes" function requires at least 3 input argument(s).');
elseif nargin > 4
	error('The "Imop_Phase_NewFromSlopes" function cannot have more than 4 input argument(s).');
end
if nargin<=3
	nb_coeffs=0;
end
err_message = char(ones(256,1,'int8'));
Phase = 0;

[err_nb, err_message, Phase, filter, nb_coeffs] = calllib('WaveKitRuntime', 'Imop_Phase_NewFromSlopes', err_message, Phase, HasoSlopes, m_type, filter, nb_coeffs);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
