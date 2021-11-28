function err_message = Imop_ComputePhaseSet_SetZonalFilter(ComputePhaseSet, params)

% IMOP_COMPUTEPHASESET_SETZONALFILTER Set filter for zonal phase reconstruction.
%    The aberrations to filter are selected using the boolean values in the params array.
%    (0 = aberration is removed).
%    - params[0] : tiltx
%    - params[1] : tilty
%    - params[2] : curvature
%    - params[3] : astigmatism 0 degree
%    - params[4] : astigmatism 45 degree
%    WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    params           Array of aberrations to filter.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 2
	error('The "Imop_ComputePhaseSet_SetZonalFilter" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, params] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_SetZonalFilter', err_message, ComputePhaseSet, params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
