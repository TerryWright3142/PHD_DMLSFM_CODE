function err_message = Imop_Surface_Prepare(Surface, noise_threshold)

% IMOP_SURFACE_PREPARE Threshold surface values to remove noise and normalize such as sum(values) = 1
% 
%    Surface          Surface object adress.
%                     
%    noise_threshold  Noise threshold between min and max of Surface pixel values.
%                     
%    err_message      Error message, empty if no error occured.
%                     
% 

if nargin ~= 2
	error('The "Imop_Surface_Prepare" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Surface_Prepare', err_message, Surface, noise_threshold);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
