function Imop_Diversity_ComputeTF()

% IMOP_DIVERSITY_COMPUTETF Not available
% 
% 

if nargin ~= 0
	error('The "Imop_Diversity_ComputeTF" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Diversity_ComputeTF');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
