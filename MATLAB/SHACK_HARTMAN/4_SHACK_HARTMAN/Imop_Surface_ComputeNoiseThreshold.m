function [err_message, noise_threshold] = Imop_Surface_ComputeNoiseThreshold(Surface)

% IMOP_SURFACE_COMPUTENOISETHRESHOLD Compute noise threshold
% 
%    Surface          Surface object adress.
%                     
%    err_message      Error message, empty if no error occured.
%                     
%    noise_threshold  Noise threshold
%                     
% 

if nargin ~= 1
	error('The "Imop_Surface_ComputeNoiseThreshold" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
noise_threshold = 0;

[err_nb, err_message, noise_threshold] = calllib('WaveKitRuntime', 'Imop_Surface_ComputeNoiseThreshold', err_message, Surface, noise_threshold);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
