function err_message = Imop_ComputePhaseSet_SetZonalPrefs(ComputePhaseSet, nb_weak_iterations, nb_max_iterations, residual_limit)

% IMOP_COMPUTEPHASESET_SETZONALPREFS Set parameters for zonal phase reconstruction.
%    WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
% 
%    ComputePhaseSet     ComputePhaseSet object adress.
%                        
%    nb_weak_iterations  Maximum number of weak iterations.
%                        A weak iteration is an iteration for which the variation
%                        of the residue from previous iteration is below the residual_limit
%                        multiplied by the number of microlenses of the Haso.
%                        
%    nb_max_iterations   Maximum number of iterations.
%                        
%    residual_limit      Residual variation limit.
%                        
%    err_message         Error message, empty if no error occured.
%                        
% 

if nargin ~= 4
	error('The "Imop_ComputePhaseSet_SetZonalPrefs" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputePhaseSet_SetZonalPrefs', err_message, ComputePhaseSet, nb_weak_iterations, nb_max_iterations, residual_limit);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
