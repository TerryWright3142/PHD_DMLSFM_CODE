% OK 17/5/18
addpath('../1_WAVEKITX64/Matlab/M_Files');
Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/3_CONFIGURATION_FILES/HASO4_VIS_7527.dat';
message = char(ones(256,1,'int8'));
hasodata_file_path = 'data_phase_computation_example.has';
%%load the hasoslopes contained into HAS file
[message,HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(hasodata_file_path);

%% set TypePhase = E_COMPUTEPHASESET_MODAL_ZERNIKE to use Zernike reconstruction.
TypePhase = E_COMPUTEPHASESET_MODAL_ZERNIKE;
[message,ComputePhaseSet] = Imop_ComputePhaseSet_NewFromTypePhase(TypePhase);
%%load the hasoslopes contained into HAS file
[message,HasoSlopes] = Imop_HasoSlopes_NewFromHasFile(hasodata_file_path);
%%create the pupil object from the hasoslopes
[message,Pupil] = Imop_Pupil_NewFromHasoSlopes(HasoSlopes);
%% Compute the geometric parameters of the Zernike pupil from a cPupil input.
center = struct('X',0,'Y',0);
radius = 0.0;
[message,center,radius] = Imop_PupilCompute_FitZernikePupil(Pupil,E_PUPIL_AUTOMATIC,E_PUPIL_INSCRIBED,false);
%% Create the Zernike modal coeffs object and set preferences for modal phase reconstruction
polynomial_base_to_filter = 0;
[message,Zernikes] = Imop_ModalCoef_New(E_MODALCOEF_ZERNIKE);
[message] = Imop_ModalCoef_SetZernikePrefs(Zernikes,0,32,0,polynomial_base_to_filter,center,radius);
[message,HasoData] = Imop_HasoData_New(HasoSlopes);
%% compute the modal zernike coefficients.
[message,Zernikes] = Imop_Compute_CoefFromHasoData(ComputePhaseSet,HasoData,Zernikes);
%%retrieve the Zernike coefficients given this pupil.
size = 0;
[message,size] = Imop_ModalCoef_GetDim(Zernikes);
coeff = zeros(size,1,'uint32');
indexes = zeros(size,1,'uint32');
[message,coeff,indexes,Pupil] = Imop_ModalCoef_GetData(Zernikes,coeff,indexes,Pupil);
for i=0:size-1
    fprintf('zernike coeff at index %d  : %f\n', indexes(i+1), coeff(i+1));
end
%% Delete used objects.
[message] = Imop_HasoData_Delete(HasoData);
[message] = Imop_ModalCoef_Delete(Zernikes);
[message] = Imop_HasoSlopes_Delete(HasoSlopes);
[message] = Imop_ComputePhaseSet_Delete(ComputePhaseSet);
[message] = Imop_Pupil_Delete(Pupil);

Imop_Runtime_Unload_x64();
clear; 
