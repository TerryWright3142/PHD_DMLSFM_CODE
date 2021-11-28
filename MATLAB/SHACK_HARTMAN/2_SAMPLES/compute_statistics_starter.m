% OK 17/5/18

addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
message = char(ones(256,1,'int8'));
hasodata_file_path = 'data_phase_computation_example.has';
%%load the hasoslopes contained into HAS file
[message,HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(hasodata_file_path);

%% Create Phase object
filter_size = 5;
filter = ones(filter_size,1,'int8');
%%keep tiltx, tilty, curvature, astigmatism 0 degree, astigmatism 45 degree
for i=0:filter_size-1
    filter(i+1) = 1;
end
[message,phase] = Imop_Phase_NewFromSlopes(HasoSlopes,E_COMPUTEPHASESET_ZONAL,filter);
%% 
[err_message, dimensions, steps] = Imop_Phase_GetDimensionsAndSteps(phase);
%% 
phase_buffer = zeros(dimensions.X, dimensions.Y);
[message,Pupil] = Imop_Pupil_NewFromHasoSlopes(HasoSlopes);
%% 
[message, phase_buffer, Pupil] = Imop_Phase_GetData(phase, phase_buffer, Pupil);
phase_buffer(isnan(phase_buffer)) = 0;
imagesc(phase_buffer);
%% Retrieve statistics data
[message,phase_rms,phase_pv,phase_max,phase_min] = Imop_Phase_GetStatistics(phase);
fprintf('RMS value : %.3f \n', phase_rms);
fprintf('PV  value : %.3f \n', phase_pv);
%% Delete used objects.
[message] = Imop_Phase_Delete(phase);
[message] = Imop_HasoSlopes_Delete(hasoslopes);

Imop_Runtime_Unload_x64();
clear; 
