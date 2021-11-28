%OK 17/05/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
message = char(ones(256,1,'int8'));
hasodata_file_path = 'data_phase_computation_example.has';
%%load the hasoslopes contained into HAS file
[message,HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(hasodata_file_path);
%% Create the Zernike modal coeffs object and compute coefficients values from slopes
[message,Zernikes] = Imop_ModalCoef_NewZernikeFromSlopes(E_ZERNIKE_NORM_STD,32,HasoSlopes);
size = 0;
[message,size] = Imop_ModalCoef_GetDim(Zernikes);
coeff = zeros(size,1,'uint32');
indexes = zeros(size,1,'uint32');
[message,Pupil] = Imop_Pupil_NewFromHasoSlopes(HasoSlopes);
[message,coeff,indexes,Pupil] = Imop_ModalCoef_GetData(Zernikes,coeff,indexes,Pupil);
for i=0:size-1
    fprintf('zernike coeff at index %d  : %f\n', indexes(i+1), coeff(i+1));
end
%% Delete used objects.
[message] = Imop_ModalCoef_Delete(Zernikes);
[message] = Imop_HasoSlopes_Delete(HasoSlopes);
[message] = Imop_Pupil_Delete(Pupil);

Imop_Runtime_Unload_x64();
clear; 
