function [err_message, nb_weak_iterations, nb_max_iterations, residual_limit] = Imop_ComputePhaseSet_GetZonalPrefs(ComputePhaseSet)

% IMOP_COMPUTEPHASESET_GETZONALPREFS Get parameters for zonal phase reconstruction.
%    WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet     ComputePhaseSet object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    nb_weak_iterations  Maximum number of weak iterations.
%                        A weak iteration is defined as an iteration for which the variation
%                        of the residue from previous iteration is below the residual_limit
%                        multiplied by the number of microlenses of the Haso.
%                        
%    nb_max_iterations   Maximum number of iterations.
%                        
%    residual_limit      Residual variation limit.
%                        
% 

if nargin ~= 1
	error('The "Imop_ComputePhaseSet_GetZonalPrefs" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_weak_iterations = 0;
nb_max_iterations = 0;
residual_limit = 0;

[err_nb, err_message, nb_weak_iterations, nb_max_iterations, residual_limit] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_GetZonalPrefs', err_message, ComputePhaseSet, nb_weak_iterations, nb_max_iterations, residual_limit);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
