function Imop_Runtime_Load()

% IMOP_RUNTIME_LOAD Load Runtime main dll x64.
% 
%    Load the Imagine Optic Runtime.
%    You have to call this function before calling any function of the Imagine Optic WaveKit Matlab interface.

disp('Imagine Optic Runtime for Matlab® on Windows® 64-bits platforms.');
disp('4.1.0 version.');
disp('© 2015 <a href = "http://www.imagine-optic.com/">Imagine Optic</a>.');

if Imop_Runtime_IsLoaded() == 0
    dll_file = fullfile(fileparts(which(mfilename)),'.', 'Lib','c_interface_vc100_x64.dll');
    header_file = fullfile(fileparts(which(mfilename)),'.', 'Include', 'c_interface.h');
    loadlibrary(dll_file, header_file, 'alias', 'WaveKitRuntime');
else
    disp('Imagine Optic Runtime is already loaded.');
end
