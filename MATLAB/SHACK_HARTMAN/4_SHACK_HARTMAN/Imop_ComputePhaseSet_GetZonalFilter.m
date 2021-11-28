function [err_message, params] = Imop_ComputePhaseSet_GetZonalFilter(ComputePhaseSet)

% IMOP_COMPUTEPHASESET_GETZONALFILTER Get filter for zonal phase reconstruction.
%    The filter is defined by the indices of array params that must be filtered.
%    see Imop_ComputePhaseSet_GetLegendreFilter for details.
%    WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    params           Array of aberrations to filter.
%                     
% 

if nargin ~= 1
	error('The "Imop_ComputePhaseSet_GetZonalFilter" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
params = 0;

[err_nb, err_message, params] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_GetZonalFilter', err_message, ComputePhaseSet, params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
