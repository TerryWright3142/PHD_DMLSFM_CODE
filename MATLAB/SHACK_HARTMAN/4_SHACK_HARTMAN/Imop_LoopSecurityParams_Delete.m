function err_message = Imop_LoopSecurityParams_Delete(security_params)

% IMOP_LOOPSECURITYPARAMS_DELETE Destruction
% 
%    security_params  Pointer to threaded loop object.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 1
	error('The "Imop_LoopSecurityParams_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_LoopSecurityParams_Delete', err_message, security_params);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
