function loaded = Imop_Runtime_IsLoaded()

% IMOP_RUNTIME_ISLOADED Check if Runtime main dll is loaded.
% 
%    Return true if the Imagine Optic Runtime is loaded.

loaded = libisloaded('WaveKitRuntime');
