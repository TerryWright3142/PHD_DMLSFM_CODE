function err_message = Imop_HasoEngine_SetAlgoType(HasoEngine, algo_type)

% IMOP_HASOENGINE_SETALGOTYPE Spots detection algorithm type setter.
% 
%    HasoEngine   HasoEngine object adress.
%                 
%    algo_type    E_SPOTDETECT_T spots detection algorithm type.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 2
	error('The "Imop_HasoEngine_SetAlgoType" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoEngine_SetAlgoType', err_message, HasoEngine, algo_type);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
