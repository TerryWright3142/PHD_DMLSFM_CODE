function err_message = Imop_LoopSecurityActivation_Delete(security_activation)

% IMOP_LOOPSECURITYACTIVATION_DELETE Destruction
% 
%    security_activation  Pointer to Closed Loop security activation object adress.
%                         
%    err_message          Error message, empty if no error occured.
%                         
% 

if nargin ~= 1
	error('The "Imop_LoopSecurityActivation_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_LoopSecurityActivation_Delete', err_message, security_activation);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
