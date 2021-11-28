
% OK 17/5/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
message = char(ones(256,1,'int8'));
hasodata_file_path = 'data_phase_computation_example.has';
%%load the hasoslopes contained into HAS file
[message,HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(hasodata_file_path);
%% Create ComputePhaseSet setted on zonal reconstruction
[message,compute_phase_set] = Imop_ComputePhaseSet_NewFromTypePhase(E_COMPUTEPHASESET_ZONAL);
%% Create HasoData object
[message,hasodata] = Imop_HasoData_NewFromFile(hasodata_file_path);
%% Create Phase object
dimensions = struct('X',0,'Y',0);
step = struct('X',0,'Y',0);
[message,dimensions,step] = Imop_HasoData_GetDimensionsAndSteps(hasodata);
[message,phase] = Imop_Phase_NewFromDimAndSteps(dimensions,step);
[message,phase] = Imop_Compute_PhaseZonal(compute_phase_set,hasodata,phase);
%% Retrieve statistics data
[message,phase_rms,phase_pv,phase_max,phase_min] = Imop_Phase_GetStatistics(phase);
fprintf('RMS value : %.3f \n', phase_rms);
fprintf('PV  value : %.3f \n', phase_pv);
%% Delete used objects.
[message] = Imop_HasoSlopes_Delete(HasoSlopes);
[message] = Imop_HasoData_Delete(hasodata);
[message] = Imop_Phase_Delete(phase);
[message] = Imop_ComputePhaseSet_Delete(compute_phase_set);

Imop_Runtime_Unload_x64();
clear; 
