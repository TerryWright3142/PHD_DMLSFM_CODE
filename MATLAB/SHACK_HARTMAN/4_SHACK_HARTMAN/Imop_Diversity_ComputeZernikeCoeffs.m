function Imop_Diversity_ComputeZernikeCoeffs()

% IMOP_DIVERSITY_COMPUTEZERNIKECOEFFS Not available
% 
% 

if nargin ~= 0
	error('The "Imop_Diversity_ComputeZernikeCoeffs" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Diversity_ComputeZernikeCoeffs');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
