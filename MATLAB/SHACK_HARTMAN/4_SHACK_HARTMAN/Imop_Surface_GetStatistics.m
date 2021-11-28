function [err_message, rms, pv, max, min] = Imop_Surface_GetStatistics(Surface)

% IMOP_SURFACE_GETSTATISTICS Get Surface statistics.
% 
%    Surface      Surface object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    rms          Surface root mean square deviation.
%                 
%    pv           Surface peak to valley.
%                 
%    max          Surface maximum.
%                 
%    min          Surface minimum.
%                 
% 

if nargin ~= 1
	error('The "Imop_Surface_GetStatistics" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
rms = 0;
pv = 0;
max = 0;
min = 0;

[err_nb, err_message, rms, pv, max, min] = calllib('WaveKitRuntime', 'Imop_Surface_GetStatistics', err_message, Surface, rms, pv, max, min);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
