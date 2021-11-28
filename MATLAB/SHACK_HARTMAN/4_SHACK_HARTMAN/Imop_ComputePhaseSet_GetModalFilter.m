function [err_message, nb_coeffs_to_filter, coeffs_to_filter] = Imop_ComputePhaseSet_GetModalFilter(ComputePhaseSet, coeffs_to_filter)

% IMOP_COMPUTEPHASESET_GETMODALFILTER Get filter for phase reconstruction from Modal decomposition.
%    The filter is defined by the indices of polynomials that must be filtered.
%    WARNING! ComputePhaseSet object type must not be E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet      ComputePhaseSet object adress.
%                         
%    coeffs_to_filter     List of indices of the coefficients to filter in the polynomial base.
%                         
%    err_message          Error message, empty if no error occured.
%                         
%    nb_coeffs_to_filter  Number of the coefficients to filter in the polynomial base.
%                         
% 

if nargin ~= 2
	error('The "Imop_ComputePhaseSet_GetModalFilter" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_coeffs_to_filter = 0;

[err_nb, err_message, nb_coeffs_to_filter, coeffs_to_filter] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_GetModalFilter', err_message, ComputePhaseSet, nb_coeffs_to_filter, coeffs_to_filter);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
