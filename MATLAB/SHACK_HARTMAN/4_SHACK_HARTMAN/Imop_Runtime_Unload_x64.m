function Imop_Runtime_Unload()

% IMOP_RUNTIME_UNLOAD Unload Runtime main dll x64
% 
%    Unload the Imagine Optic Runtime.
%                             

if Imop_Runtime_IsLoaded
	unloadlibrary 'WaveKitRuntime';
	disp('The Imagine Optic Runtime has been successfully unloaded.');
else
	disp('The Imagine Optic Runtime is not loaded.');
end
