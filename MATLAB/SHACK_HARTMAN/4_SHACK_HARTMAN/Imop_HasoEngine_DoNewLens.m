function err_message = Imop_HasoEngine_DoNewLens(HasoEngine)

% IMOP_HASOENGINE_DONEWLENS Reset spots detection. In particular, reinitialize the spots tracking.
% 
%    HasoEngine   HasoEngine object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 1
	error('The "Imop_HasoEngine_DoNewLens" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_HasoEngine_DoNewLens', err_message, HasoEngine);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
