function [err_message, security_params] = Imop_LoopSecurityParams_NewHigh()

% IMOP_LOOPSECURITYPARAMS_NEWHIGH Construction from Imagine Optic recommended high security parameters
% 
%    err_message      Error message, empty if no error occured.
%                     
%    security_params  Pointer to Closed Loop security params object adress.
%                     
% 

if nargin ~= 0
	error('The "Imop_LoopSecurityParams_NewHigh" function requires 0 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
security_params = 0;

[err_nb, err_message, security_params] = calllib('WaveKitRuntime', 'Imop_LoopSecurityParams_NewHigh', err_message, security_params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
