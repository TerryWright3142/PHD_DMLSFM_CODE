function [err_message, rms, pv, max, min] = Imop_Phase_GetStatistics(Phase)

% IMOP_PHASE_GETSTATISTICS Compute statistics on Phase
% 
%    Phase        Phase object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    rms          Phase root mean square deviation.
%                 
%    pv           Phase peak to valley.
%                 
%    max          Phase maximum.
%                 
%    min          Phase minimum.
%                 
% 

if nargin ~= 1
	error('The "Imop_Phase_GetStatistics" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
rms = 0;
pv = 0;
max = 0;
min = 0;

[err_nb, err_message, rms, pv, max, min] = calllib('WaveKitRuntime', 'Imop_Phase_GetStatistics', err_message, Phase, rms, pv, max, min);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
