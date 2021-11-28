function [err_message, Phase] = Imop_ComputeSlopes_PhaseZonal(ComputePhaseSet, HasoSlopes, Phase)

% IMOP_COMPUTESLOPES_PHASEZONAL Compute phase from HasoSlopes.
%    Filter some aberrations of reconstructed phase,
%    depending on the filter given in zonal phase reconstruction parameters provided by ComputePhaseSet.
% 
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    HasoSlopes       HasoSlopes object adress.
%                     
%    Phase            phase object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_ComputeSlopes_PhaseZonal" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_ComputeSlopes_PhaseZonal', err_message, ComputePhaseSet, HasoSlopes, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
