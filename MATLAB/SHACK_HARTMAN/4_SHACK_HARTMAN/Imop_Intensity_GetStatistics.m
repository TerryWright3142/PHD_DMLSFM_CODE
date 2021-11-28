function [err_message, rms, pv, max, min] = Imop_Intensity_GetStatistics(Intensity)

% IMOP_INTENSITY_GETSTATISTICS Compute statistics on Intensity
% 
%    Intensity    Intensity object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    rms          Intensity root mean square deviation.
%                 
%    pv           Intensity peak to valley.
%                 
%    max          Intensity maximum.
%                 
%    min          Intensity minimum.
%                 
% 

if nargin ~= 1
	error('The "Imop_Intensity_GetStatistics" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
rms = 0;
pv = 0;
max = 0;
min = 0;

[err_nb, err_message, rms, pv, max, min] = calllib('WaveKitRuntime', 'Imop_Intensity_GetStatistics', err_message, Intensity, rms, pv, max, min);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
