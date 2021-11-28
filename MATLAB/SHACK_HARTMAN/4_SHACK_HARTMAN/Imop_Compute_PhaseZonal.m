function [err_message, Phase] = Imop_Compute_PhaseZonal(ComputePhaseSet, HasoData, Phase)

% IMOP_COMPUTE_PHASEZONAL Compute phase from processed slopes of the input HasoData.
% Filter some aberrations of reconstructed phase,
%    depending on the filter given in zonal phase reconstruction parameters provided by ComputePhaseSet.
%    ComputePhaseSet  ComputePhaseSet object adress.
%                     
%    HasoData         HasoData object adress.
%                     
%    Phase            phase object adress. Phase unit is um. Phase sampling steps unit is um.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 3
	error('The "Imop_Compute_PhaseZonal" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Compute_PhaseZonal', err_message, ComputePhaseSet, HasoData, Phase);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
