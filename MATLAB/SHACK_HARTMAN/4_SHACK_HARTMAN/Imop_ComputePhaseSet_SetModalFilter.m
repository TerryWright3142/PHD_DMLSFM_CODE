function err_message = Imop_ComputePhaseSet_SetModalFilter(ComputePhaseSet, nb_coeffs_to_filter, coeffs_to_filter)

% IMOP_COMPUTEPHASESET_SETMODALFILTER Set filter for phase reconstruction from modal decomposition.
%    The filter is defined by the indices of polynomials that must be filtered.
%    WARNING! ComputePhaseSet object type must not be E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet      ComputePhaseSet object adress.
%                         
%    nb_coeffs_to_filter  Number of the coefficients to filter in the polynomial base.
%                         
%    coeffs_to_filter     List of indices of the coefficients to filter in the polynomial base.
%                         
%    err_message          Error message, empty if no error occured.
%                         
% 

if nargin ~= 3
	error('The "Imop_ComputePhaseSet_SetModalFilter" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, coeffs_to_filter] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_SetModalFilter', err_message, ComputePhaseSet, nb_coeffs_to_filter, coeffs_to_filter);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
