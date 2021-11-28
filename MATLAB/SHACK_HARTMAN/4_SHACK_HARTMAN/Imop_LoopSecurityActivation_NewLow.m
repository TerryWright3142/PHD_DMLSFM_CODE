function [err_message, security_activation] = Imop_LoopSecurityActivation_NewLow()

% IMOP_LOOPSECURITYACTIVATION_NEWLOW Construction from Imagine Optic recommended low security activations
% 
%    err_message          Error message, empty if no error occured.
%                         
%    security_activation  Pointer to Closed Loop security activation object adress.
%                         
% 

if nargin ~= 0
	error('The "Imop_LoopSecurityActivation_NewLow" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
security_activation = 0;

[err_nb, err_message, security_activation] = calllib('WaveKitRuntime', 'Imop_LoopSecurityActivation_NewLow', err_message, security_activation);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
