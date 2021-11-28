function Imop_Diversity_EncircledEnergy()

% IMOP_DIVERSITY_ENCIRCLEDENERGY Not available
% 
% 

if nargin ~= 0
	error('The "Imop_Diversity_EncircledEnergy" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_Diversity_EncircledEnergy');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
