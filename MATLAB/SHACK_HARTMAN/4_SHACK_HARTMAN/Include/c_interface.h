#pragma pack(4)
struct uint2D {
	unsigned int  X;
	unsigned int  Y;
};
typedef struct uint2D uint2D;
struct int2D {
	int  X;
	int  Y;
};
typedef struct int2D int2D;
struct float2D {
	float  X;
	float  Y;
};
typedef struct float2D float2D;
int Imop_Camera_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_Camera_Delete(char*,unsigned int);
int Imop_Camera_SnapImage(char*,unsigned int,unsigned int,unsigned char ,unsigned int);
int Imop_Camera_Start(char*,unsigned int,unsigned char ,unsigned char );
int Imop_Camera_Stop(char*,unsigned int);
int Imop_Camera_GetImage(char*,unsigned int,unsigned int,unsigned char ,unsigned int);
int Imop_Camera_GetSequence(char*,unsigned int,unsigned short ,unsigned int *);
int Imop_Camera_AsyncImageReady(char*,unsigned int,unsigned char*);
int Imop_Camera_GetState(char*,unsigned int,unsigned char*,unsigned char*,unsigned char*);
int Imop_Camera_CallSpecificFeature(char*,unsigned int,char*);
int Imop_Camera_IsHasoSensor();
int Imop_Camera_GetSize(char*,unsigned int,uint2D*,unsigned short*);
int Imop_Camera_SetBackground(char*,unsigned int,unsigned int);
int Imop_Camera_GetBackground(char*,unsigned int,unsigned int);
int Imop_Camera_SetNbImagesToSum(char*,unsigned int,unsigned int );
int Imop_Camera_GetNbImagesToSum(char*,unsigned int,unsigned int*);
int Imop_Camera_SetTimeOut(char*,unsigned int,unsigned int );
int Imop_Camera_GetTimeOut(char*,unsigned int,unsigned int*);
int Imop_Camera_GetParameterInt(char*,unsigned int,char*,int *);
int Imop_Camera_GetParameterReal(char*,unsigned int,char*,double *);
int Imop_Camera_GetParameterBoolean(char*,unsigned int,char*,unsigned char*);
int Imop_Camera_GetParameterString(char*,unsigned int,char*,char*);
int Imop_Camera_SetParameterInt(char*,unsigned int,char*,int );
int Imop_Camera_SetParameterReal(char*,unsigned int,char*,double );
int Imop_Camera_SetParameterBoolean(char*,unsigned int,char*,unsigned char);
int Imop_Camera_SetParameterString(char*,unsigned int,char*,char*);
int Imop_CameraSet_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_CameraSet_Delete(char*,unsigned int);
int Imop_CameraSet_GetSpecifications(char*,unsigned int,char*,char*,char*,int *,int *,float *,float *,unsigned char *,unsigned char*,long *,float *,unsigned int *,unsigned int *,int *,int *);
int Imop_CameraSet_GetSpecificFeaturesListSize(char*,unsigned int,int*);
int Imop_CameraSet_GetSpecificFeatureName(char*,unsigned int,int ,char*);
int Imop_CameraSet_GetParametersListSize(char*,unsigned int,int*);
int Imop_CameraSet_GetParameterName(char*,unsigned int,int ,char*);
int Imop_CameraSet_GetParameterType(char*,unsigned int,char*,int*);
int Imop_CameraSet_GetParameterOption(char*,unsigned int,char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_CameraSet_GetParameterIntLimits(char*,unsigned int,char*,int*,int*);
int Imop_CameraSet_GetParameterRealLimits(char*,unsigned int,char*,double*,double*);
int Imop_CameraSet_GetAvailableValuesListSize(char*,unsigned int,char*,int*);
int Imop_CameraSet_GetAvailableValue(char*,unsigned int,char*,unsigned int ,char*);
int Imop_CameraSet_GetParameterIntDefaultValue(char*,unsigned int,char*,int*);
int Imop_CameraSet_GetParameterRealDefaultValue(char*,unsigned int,char*,double*);
int Imop_CameraSet_GetParameterBooleanDefaultValue(char*,unsigned int,char*,unsigned char*);
int Imop_CameraSet_GetParameterStringDefaultValue(char*,unsigned int,char*,char*);
int Imop_Server_New(char*,unsigned int *,char*,unsigned short );
int Imop_Server_Start(char*,unsigned int);
int Imop_Server_AddData(char*,unsigned int,char*,int );
int Imop_Server_SetBool(char*,unsigned int,char*,unsigned char);
int Imop_Server_SetInt(char*,unsigned int,char*,int );
int Imop_Server_SetReal(char*,unsigned int,char*,float );
int Imop_Server_SetString(char*,unsigned int,char*,char*);
int Imop_Server_SetSlopes(char*,unsigned int,char*,unsigned int);
int Imop_Server_SetImage(char*,unsigned int,char*,unsigned int);
int Imop_Server_Delete(char*,unsigned int);
int Imop_Client_New(char*,unsigned int *,char*,unsigned short ,unsigned int );
int Imop_Client_GetDataNumber(char*,unsigned int,int *);
int Imop_Client_GetDataNameAndType(char*,unsigned int,int   ,char*,int *);
int Imop_Client_GetBool(char*,unsigned int,char *,unsigned char*,int*);
int Imop_Client_GetInt(char*,unsigned int,char *,int *,int*);
int Imop_Client_GetReal(char*,unsigned int,char *,float*,int*);
int Imop_Client_GetString(char*,unsigned int,char *,char*,int*);
int Imop_Client_GetSlopes(char*,unsigned int,char *,unsigned int,int*);
int Imop_Client_GetImage(char*,unsigned int,char *,unsigned int,int*);
int Imop_Client_Delete(char*,unsigned int);
int Imop_HasoSlopes_NewFromDimensions(char*,unsigned int *,uint2D*,float2D*,char*);
int Imop_HasoSlopes_NewFromHasFile(char*,unsigned int *,char*);
int Imop_HasoSlopes_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_HasoSlopes_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_HasoSlopes_NewFromHasoData(char*,unsigned int *,unsigned int,unsigned char);
int Imop_HasoSlopes_NewFromImage(char*,unsigned int *,unsigned int,char*,uint2D*);
int Imop_HasoSlopes_NewFromModalCoef(char*,unsigned int *,unsigned int,char*);
int Imop_HasoSlopes_Delete(char*,unsigned int);
int Imop_HasoSlopes_GetInfo(char*,unsigned int,char*,uint2D*,float2D*);
int Imop_HasoSlopes_SetWaveLength(char*,unsigned int,float );
int Imop_HasoSlopes_GetSlopesX(char*,unsigned int,float*);
int Imop_HasoSlopes_GetSlopesY(char*,unsigned int,float*);
int Imop_HasoSlopes_GetIntensity(char*,unsigned int,int*);
int Imop_HasoSlopes_GetPupilBuffer(char*,unsigned int,unsigned char*);
int Imop_HasoSlopes_GetPupilPointer(char*,unsigned int,unsigned int *);
int Imop_HasoSlopes_SetSlopesX(char*,unsigned int,float*);
int Imop_HasoSlopes_SetSlopesY(char*,unsigned int,float*);
int Imop_HasoSlopes_SetIntensity(char*,unsigned int,int*);
int Imop_HasoSlopes_SetPupil(char*,unsigned int,unsigned char*);
int Imop_HasoSlopes_SaveToFile(char*,unsigned int,char*,char*,char*);
int Imop_HasoSlopes_Assignment(char*,unsigned int,unsigned int);
int Imop_HasoSlopes_GetGeometricProperties(char*,unsigned int,float*,float*,float*,float*,float*,float*,float*,float*);
int Imop_HasoSlopes_HasAliasing(char*,unsigned int,float ,unsigned char*);
int Imop_HasoSlopes_Filter(char*,unsigned int,unsigned int,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned char ,float*,float*,float*,float*,float*,float*);
int Imop_Image_New(char*,unsigned int *,uint2D*,unsigned short );
int Imop_Image_NewFromFile(char*,unsigned int *,char*);
int Imop_Image_NewFromSubtraction(char*,unsigned int,unsigned int,unsigned int *);
int Imop_Image_NewFromConfig(char*,unsigned int *,char*);
int Imop_Image_NewCustom(char*,unsigned int *,uint2D*,unsigned short ,char*,int ,float ,int ,char *,unsigned int *);
int Imop_Image_Delete(char*,unsigned int);
int Imop_Image_Load(char*,unsigned int,char*);
int Imop_Image_Save(char*,unsigned int,char*,char*);
int Imop_Image_IsHasoImage();
int Imop_Image_GetHasoSerialNumber(char*,unsigned int,char*);
int Imop_Image_GetInfo(char*,unsigned int,char*,double*,char*,unsigned char*,unsigned char*,long*);
int Imop_Image_GetAcquisitionInfo(char*,unsigned int,int*,int*,float*,int*,char*);
int Imop_Image_GetInfo_FromFile(char*,char*,unsigned short*,uint2D*,double*,char *,char *,float*,unsigned int*,unsigned int*,unsigned int*);
int Imop_Image_GetSize(char*,unsigned int,uint2D*,unsigned short*);
int Imop_Image_GetData(char*,unsigned int,unsigned int*);
int Imop_Image_SetData(char*,unsigned int,unsigned int*);
int Imop_Image_GetDataU8(char*,unsigned int,unsigned char*);
int Imop_Image_GetDataU16(char*,unsigned int,unsigned short*);
int Imop_Image_GetDataU32(char*,unsigned int,unsigned int*);
int Imop_Image_GetStatistics(char*,unsigned int,unsigned int ,unsigned int*,unsigned int*,float*);
int Imop_Image_SubtractionAB(char*,unsigned int,unsigned int);
int Imop_Image_SubtractionABC(char*,unsigned int,unsigned int,unsigned int);
int Imop_Image_Assignment(char*,unsigned int,unsigned int);
int Imop_Pupil_NewFromDimensions(char*,unsigned int *,uint2D*,float2D*,unsigned char );
int Imop_Pupil_NewFromHasoSlopes(char*,unsigned int *,unsigned int);
int Imop_Pupil_NewFromLegendrePupil(char*,unsigned int *,float2D*,uint2D*,float2D*,float2D*);
int Imop_Pupil_NewFromZernikePupil(char*,unsigned int *,float2D*,uint2D*,float2D*,float );
int Imop_Pupil_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_Pupil_Delete(char*,unsigned int);
int Imop_Pupil_Assignment(char*,unsigned int,unsigned int);
int Imop_Pupil_AND(char*,unsigned int,unsigned int);
int Imop_Pupil_OR(char*,unsigned int,unsigned int);
int Imop_Pupil_INVERT(char*,unsigned int);
int Imop_Pupil_GetBarycenter(char*,unsigned int,float2D*);
int Imop_Pupil_GetNbEnlightedSubapertures(char*,unsigned int,int*);
int Imop_Pupil_Resize(char*,unsigned int,unsigned char ,unsigned int);
int Imop_Pupil_HasCentralOccultation(char*,unsigned int,unsigned char*);
int Imop_Pupil_RegionsStats(char*,unsigned int,int *,int *,int *);
int Imop_Pupil_GetDimensions(char*,unsigned int,uint2D*,float2D*);
int Imop_Pupil_GetData(char*,unsigned int,unsigned char*);
int Imop_Pupil_SetData(char*,unsigned int,unsigned char*);
int Imop_Surface_New(char*,uint2D*,float2D*,unsigned int *);
int Imop_Surface_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_Surface_Delete(char*,unsigned int);
int Imop_Surface_GetData(char*,unsigned int,float*);
int Imop_Surface_SetData(char*,unsigned int,float*);
int Imop_Surface_GetDimensions(char*,unsigned int,uint2D*,float2D*);
int Imop_Surface_GetStatistics(char*,unsigned int,double*,double*,double*,double*);
int Imop_Surface_Crop(char*,unsigned int,unsigned int,float2D*,uint2D*);
int Imop_Surface_GetSpotArea(char*,unsigned int,unsigned int,float2D*,float2D*,unsigned char ,unsigned char );
int Imop_Surface_ComputeNoiseThreshold(char*,unsigned int,float *);
int Imop_Surface_Prepare(char*,unsigned int,float );
int Imop_Surface_BoundingShapes(char*,unsigned int,float ,float2D*,float *,float *,float *,float *);
int Imop_Surface_EncircledEnergy(char*,unsigned int,float2D*,float ,float *);
int Imop_Surface_EnsquaredEnergy(char*,unsigned int,float2D*,float ,float *);
int Imop_Surface_TransposeAndFlip(char*,unsigned int,unsigned char,unsigned char,unsigned char,unsigned int);
int Imop_Surface_Zoom(char*,unsigned int,unsigned int ,unsigned int);
int Imop_Surface_Resize(char*,unsigned int,unsigned char ,unsigned int);
int Imop_Surface_Projection(char*,unsigned int,unsigned int ,unsigned int ,float ,float*,float*);
int Imop_Create_Directory_Path_For_Everyone(char*,char *);
int Imop_ReadConfigFileForInstall(char*,char*,char*,char*);
int Imop_CoreEngine_GetConfig(char*,char*,char*,unsigned int*,char*,uint2D*,float2D*,float2D*,unsigned short*,uint2D*,double*,double*,uint2D*,double*,double*,double*,double*,double*,char*,char*,char*);
int Imop_CoreEngine_IsHasoConfigFile();
int Imop_CoreEngine_GetSerialNumber();
int Imop_CoreEngine_GetSDKConfig();
int Imop_CoreEngine_GetSoftwareConfig();
int Imop_CoreEngine_GetFocalCamConfig();
int Imop_CoreEngine_GetCameraPluginName(char*,char*,char*);
int Imop_CoreEngine_GetWavefrontCorrectorPluginName(char*,char*,char*);
int Imop_CorrDataManager_NewFromConfigsFiles(char*,unsigned int *,char*,char*);
int Imop_CorrDataManager_NewFromBackupFile(char*,unsigned int *,char*,char*);
int Imop_CorrDataManager_NewFromCopy(char*,unsigned int,unsigned int *);
int Imop_CorrDataManager_Delete(char*,unsigned int);
int Imop_CorrDataManager_GetSpecifications(char*,unsigned int,int *,char*,char*,uint2D*,float2D*,char*);
int Imop_CorrDataManager_LoadBackupFile(char*,unsigned int,char*);
int Imop_CorrDataManager_SaveBackupFile(char*,unsigned int,char*,char*);
int Imop_CorrDataManager_SetMicrolensesFocalLength(char*,unsigned int,float );
int Imop_CorrDataManager_ResetInteractionMatrix(char*,unsigned int);
int Imop_CorrDataManager_GetActuatorsCount(char*,unsigned int,int *);
int Imop_CorrDataManager_GetActuatorPrefs(char*,unsigned int,int ,float *,float *,int   *,float *);
int Imop_CorrDataManager_GetCorrectorInitPrefs(char*,unsigned int,float *,float *,int   *,float *);
int Imop_CorrDataManager_GetCorrectorPrefs(char*,unsigned int,float *,float *,int   *,float *);
int Imop_CorrDataManager_SetActuatorPrefs(char*,unsigned int,int ,float ,float ,int   ,float ,unsigned char*);
int Imop_CorrDataManager_SetCorrectorPrefs(char*,unsigned int,float *,float *,int   *,float *,unsigned char*);
int Imop_CorrDataManager_CheckRelativePositionsSaturation(char  *,unsigned int,float *,float *,int   *);
int Imop_CorrDataManager_SetCalibrationPrefs(char*,unsigned int,float );
int Imop_CorrDataManager_GetCalibrationCommands(char*,unsigned int,int ,float *,float *);
int Imop_CorrDataManager_GetCalibrationMatrixSize(char*,unsigned int,uint2D*);
int Imop_CorrDataManager_ComputeInteractionMatrix(char*,unsigned int,int    ,void *);
int Imop_CorrDataManager_UpdateInteractionMatrix(char*,unsigned int,int    ,unsigned int,unsigned int);
int Imop_CorrDataManager_GetInteractionMatrixSize(char*,unsigned int,uint2D*);
int Imop_CorrDataManager_GetInteractionMatrixBuffer(char*,unsigned int,float*);
int Imop_CorrDataManager_SetCommandMatrixPrefs(char*,unsigned int,int   ,unsigned char);
int Imop_CorrDataManager_ComputeCommandMatrix(char*,unsigned int);
int Imop_CorrDataManager_GetCommandMatrixSize(char*,unsigned int,uint2D*);
int Imop_CorrDataManager_GetCommandMatrixBuffer(char*,unsigned int,float*);
int Imop_CorrDataManager_GetGreatestCommonPupil(char*,unsigned int,unsigned char*);
int Imop_CorrDataManager_ApplyPupilMask(char*,unsigned int,unsigned int);
int Imop_CorrDataManager_RemovePupilMask(char*,unsigned int);
int Imop_CorrDataManager_GetActuatorInfluence(char*,unsigned int,int ,unsigned char,unsigned int);
int Imop_CorrDataManager_GetDiagnosticSingularVector(char*,unsigned int,float *);
int Imop_CorrDataManager_GetDiagnosticEigenVectors(char*,unsigned int,int ,unsigned int,float *);
int Imop_LoopSmoothingParams_New(char *,float   ,float   ,int     ,int     ,unsigned int *);
int Imop_LoopSmoothingParams_NewLow(char *,unsigned int *);
int Imop_LoopSmoothingParams_NewMedium(char *,unsigned int *);
int Imop_LoopSmoothingParams_NewHigh(char *,unsigned int *);
int Imop_LoopSmoothingParams_Delete(char *,unsigned int);
int Imop_LoopSmoothingParams_Set(char *,unsigned int,float   ,float   ,int     ,int     );
int Imop_LoopSmoothingParams_Get(char  *,unsigned int,float *,float *,int   *,int   *);
int Imop_LoopSmoothingParams_ComputeGainFactor(char  *,unsigned int,int     ,float *);
int Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes(char*,unsigned int,unsigned int,float *);
int Imop_CorrDataManager_ComputeClosedLoopIteration(char*,unsigned int,unsigned int,float *,unsigned char,unsigned int,float   ,float *);
int Imop_CorrDataManager_ComputeSlopesFromCommand(char*,unsigned int,float *,unsigned int);
int Imop_GetModuleVersion();
int Imop_Haso_DLLVersion();
int Imop_GetDriversError();
int Imop_GetDriversErrorSize();
int Imop_Short2LongPathName();
int Imop_FakeInterface();
int Imop_LoopSecurityParams_New(char *,int    ,int    ,int    ,float  ,unsigned int *);
int Imop_LoopSecurityParams_NewLow(char *,unsigned int *);
int Imop_LoopSecurityParams_NewMedium(char *,unsigned int *);
int Imop_LoopSecurityParams_NewHigh(char *,unsigned int *);
int Imop_LoopSecurityParams_Delete(char *,unsigned int);
int Imop_LoopSecurityParams_Set(char *,unsigned int,int    ,int    ,int    ,float  );
int Imop_LoopSecurityParams_Get(char  *,unsigned int,int   *,int   *,int   *,float *);
int Imop_LoopSecurityActivation_New(char *,unsigned char,unsigned char,unsigned char,unsigned char,unsigned int *);
int Imop_LoopSecurityActivation_NewLow(char *,unsigned int *);
int Imop_LoopSecurityActivation_NewMedium(char *,unsigned int *);
int Imop_LoopSecurityActivation_NewHigh(char *,unsigned int *);
int Imop_LoopSecurityActivation_Delete(char *,unsigned int);
int Imop_LoopSecurityActivation_Set(char *,unsigned int,unsigned char,unsigned char,unsigned char,unsigned char);
int Imop_LoopSecurityActivation_Get(char  *,unsigned int,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_LoopSecurity_Check(char  *,unsigned int,unsigned int,float   ,unsigned int,unsigned int,float *,float *,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_LoopSecurity_CheckLow(char  *,float   ,unsigned int,unsigned int,float *,float *,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_LoopSecurity_CheckMedium(char  *,float   ,unsigned int,unsigned int,float *,float *,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_LoopSecurity_CheckHigh(char  *,float   ,unsigned int,unsigned int,float *,float *,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_Stitching_New(char *,unsigned int *,char*);
int Imop_Compute_PhaseZonal(char*,unsigned int,unsigned int,unsigned int);
int Imop_Compute_PhaseModal(char*,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_Compute_PhaseModalZonal(char*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_Compute_PhaseFromCoef(char*,unsigned int,unsigned int,unsigned int);
int Imop_Compute_PhaseModalZonalFromCoef(char*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_Compute_CoefFromHasoData(char*,unsigned int,unsigned int,unsigned int);
int Imop_ComputePhaseSet_NewFromTypePhase(char*,unsigned int *,unsigned char );
int Imop_ComputePhaseSet_NewFromHasoData(char*,unsigned int *,unsigned int);
int Imop_ComputePhaseSet_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_ComputePhaseSet_Delete(char*,unsigned int);
int Imop_ComputePhaseSet_Assignment(char*,unsigned int,unsigned int);
int Imop_ComputePhaseSet_GetTypePhase(char*,unsigned int,unsigned char*);
int Imop_ComputePhaseSet_SetZonalPrefs(char*,unsigned int,unsigned int ,unsigned int ,float );
int Imop_ComputePhaseSet_GetZonalPrefs(char*,unsigned int,unsigned int*,unsigned int*,float*);
int Imop_ComputePhaseSet_SetModalFilter(char*,unsigned int,unsigned int ,unsigned int*);
int Imop_ComputePhaseSet_GetModalFilter(char*,unsigned int,unsigned int*,unsigned int*);
int Imop_ComputePhaseSet_SetZonalFilter(char*,unsigned int,unsigned char*);
int Imop_ComputePhaseSet_GetZonalFilter(char*,unsigned int,unsigned char*);
int Imop_PupilCompute_ApplyNeighborExtension(char*,unsigned int,unsigned int);
int Imop_PupilCompute_ApplyShutOfBoundaries(char*,unsigned int,unsigned int ,unsigned int);
int Imop_PupilCompute_FillOccultations(char*,unsigned int,unsigned int);
int Imop_PupilCompute_FitZernikePupil(char*,unsigned int,unsigned int ,unsigned int ,unsigned char,float2D*,float*);
int Imop_PupilCompute_FitLegendrePupil(char*,unsigned int,float2D*,float2D*);
int Imop_ComputeSlopes_PhaseZonal(char*,unsigned int,unsigned int,unsigned int);
int Imop_ComputeSlopes_PhaseModal(char*,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_ComputeSlopes_PhaseModalZonal(char*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_ComputeSlopes_PhaseModalZonalFromCoef(char*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
int Imop_ComputeSlopes_SlopesFromCoef(char*,unsigned int,unsigned int,unsigned int);
int Imop_ComputeSlopes_CoefFromSlopes(char*,unsigned int,unsigned int,unsigned int);
int Imop_HasoData_New(char*,unsigned int *,unsigned int);
int Imop_HasoData_NewFromCopy(char*,unsigned int,unsigned int *);
int Imop_HasoData_NewFromFile(char*,unsigned int *,char*);
int Imop_HasoData_Delete(char*,unsigned int);
int Imop_HasoData_Assignment(char*,unsigned int,unsigned int);
int Imop_HasoData_GetSequence(char*,unsigned int *,char*);
int Imop_HasoData_Save(char*,unsigned int,char*,char*,char*);
int Imop_HasoData_SetHasoSlopes(char*,unsigned int,unsigned int);
int Imop_HasoData_SetWaveLength(char*,unsigned int,float );
int Imop_HasoData_GetDimensionsAndSteps(char*,unsigned int,uint2D*,float2D*);
int Imop_HasoData_GetSequenceSize(char*,char*,unsigned int*);
int Imop_HasoData_GetProcessorList(char*,unsigned int,unsigned int);
int Imop_HasoData_GetInfoFromHasFile(char*,char*,char*,char*,unsigned*,uint2D*,float2D*,double*,char*,char*,double*,double*,double*);
int Imop_HasoData_GetHasoSlopes(char*,unsigned int,unsigned int,unsigned int);
int Imop_HasoData_GetComputePhaseMode(char*,unsigned int,unsigned char*);
int Imop_HasoData_GetInfo(char*,unsigned int,char*,char*,char*,unsigned*,double*,double*,unsigned*,unsigned*,unsigned*,double*,unsigned char*,unsigned char*,double*,char*,char*,char*,long*,uint2D*,double*);
int Imop_HasoData_ApplySlopesPostProcessorList(char*,unsigned int,unsigned int);
int Imop_HasoData_ResetToRawData(char*,unsigned int);
int Imop_HasoData_GetComputePhaseParameters(char*,unsigned int,unsigned int,unsigned int);
int Imop_HasoData_SetComputePhaseParameters(char*,unsigned int,unsigned int,unsigned int);
int Imop_Intensity_NewFromDimAndSteps(char*,uint2D*,float2D*,unsigned int *);
int Imop_Intensity_NewFromSlopes(char*,unsigned int *,unsigned int);
int Imop_Intensity_Delete(char*,unsigned int);
int Imop_Intensity_GetData(char*,unsigned int,float*,unsigned int);
int Imop_Intensity_GetDimensionsAndSteps(char*,unsigned int,uint2D*,float2D*);
int Imop_Intensity_GetStatistics(char*,unsigned int,double*,double*,double*,double*);
int Imop_Intensity_Resize(char*,unsigned int,unsigned char ,unsigned char ,unsigned int);
int Imop_Intensity_SetData(char*,unsigned int,float*,unsigned int);
int Imop_ModalCoef_New(char*,unsigned int *,unsigned char );
int Imop_ModalCoef_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_ModalCoef_NewFromData(char*,unsigned int *,unsigned char ,unsigned int*,float*,unsigned int,unsigned int );
int Imop_ModalCoef_NewFromFile(char*,unsigned int *,unsigned char ,char*,char*);
int Imop_ModalCoef_NewZernikeFromSlopes(char*,unsigned int *,unsigned char ,unsigned int ,unsigned int);
int Imop_ModalCoef_NewLegendreFromSlopes(char*,unsigned int *,unsigned int ,unsigned int);
int Imop_ModalCoef_Delete(char*,unsigned int);
int Imop_ModalCoef_GetTypeFromFile(char*,char*,unsigned char*);
int Imop_ModalCoef_Assignment(char*,unsigned int,unsigned int);
int Imop_ModalCoef_GetData(char*,unsigned int,float*,unsigned int*,unsigned int);
int Imop_ModalCoef_SetData(char*,unsigned int,float*,unsigned int*,int ,unsigned int);
int Imop_ModalCoef_GetDim(char*,unsigned int,unsigned int*);
int Imop_ModalCoef_GetType(char*,unsigned int,unsigned char*);
int Imop_ModalCoef_SetZernikePrefs(char*,unsigned int,unsigned char ,unsigned int ,unsigned int ,unsigned int*,float2D*,float );
int Imop_ModalCoef_GetZernikePrefs(char*,unsigned int,unsigned char*,unsigned int*,unsigned int*,unsigned int*,float2D*,float*);
int Imop_ModalCoef_SetLegendrePrefs(char*,unsigned int,unsigned int ,float2D*,float2D*);
int Imop_ModalCoef_GetLegendrePrefs(char*,unsigned int,unsigned int*,float2D*,float2D*);
int Imop_Phase_NewFromDimAndSteps(char*,uint2D*,float2D*,unsigned int *);
int Imop_Phase_NewFromPupil(char*,unsigned int,float ,unsigned int *);
int Imop_Phase_NewFromSlopes(char*,unsigned int *,unsigned int,unsigned char ,unsigned char*,unsigned char*);
int Imop_Phase_NewFromModalCoef(char*,unsigned int *,unsigned int,unsigned char*);
int Imop_Phase_Delete(char*,unsigned int);
int Imop_Phase_GetData(char*,unsigned int,float*,unsigned int);
int Imop_Phase_GetDimensionsAndSteps(char*,unsigned int,uint2D*,float2D*);
int Imop_Phase_GetPupil(char*,unsigned int,unsigned int);
int Imop_Phase_GetStatistics(char*,unsigned int,double*,double*,double*,double*);
int Imop_Phase_Resize(char*,unsigned int,unsigned char ,unsigned char ,unsigned int);
int Imop_Phase_SetData(char*,unsigned int,float*,unsigned int);
int Imop_SlopesPostProcessor_ApplyFilter(char*,unsigned int,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned int);
int Imop_SlopesPostProcessor_ApplyPupil(char*,unsigned int,unsigned int,unsigned int);
int Imop_SlopesPostProcessor_ApplySubstractor(char*,unsigned int,unsigned int,unsigned int);
int Imop_SlopesPostProcessor_ApplyAdder(char*,unsigned int,unsigned int,unsigned int);
int Imop_SlopesPostProcessor_ApplyScaler(char*,unsigned int,float ,unsigned int);
int Imop_SlopesPostProcessor_ApplyPerfectLens(char*,unsigned int,float ,unsigned char,unsigned int);
int Imop_SlopesPostProcessor_ApplyDoublePath(char*,unsigned int,unsigned char,unsigned char,unsigned int);
int Imop_SlopesPostProcessor_ApplyNeighborExtension(char*,unsigned int,unsigned int);
int Imop_SlopesPostProcessor_ApplyShutOfBoundaries(char*,unsigned int,unsigned int ,unsigned int);
int Imop_SlopesPostProcessor_ApplyModulator(char*,unsigned int,float ,float ,float ,float ,float ,float ,unsigned int);
int Imop_SlopesPostProcessor_ApplyPupilFromIntensity(char*,unsigned int,float ,unsigned int);
int Imop_SlopesPostProcessorList_New(char*,unsigned int *);
int Imop_SlopesPostProcessorList_NewFromCopy(char*,unsigned int *,unsigned int);
int Imop_SlopesPostProcessorList_NewFromHasFile(char*,unsigned int *,char*);
int Imop_SlopesPostProcessorList_Delete(char*,unsigned int);
int Imop_SlopesPostProcessorList_GetProcessorListSize(char*,unsigned int,unsigned int*);
int Imop_SlopesPostProcessorList_GetProcessorListNames(char*,unsigned int,char*);
int Imop_SlopesPostProcessorList_DeleteProcessor(char*,unsigned int,unsigned int );
int Imop_SlopesPostProcessorList_InsertSlopesPostProcessorList(char*,unsigned int,unsigned int ,unsigned int);
int Imop_SlopesPostProcessorList_InsertFilter(char*,unsigned int,unsigned int ,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned char ,unsigned char );
int Imop_SlopesPostProcessorList_GetFilterParameters(char*,unsigned int,unsigned int ,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_SlopesPostProcessorList_InsertPupil(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_GetPupilParameters(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_InsertSubstractor(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_GetSubstractorParameters(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_InsertAdder(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_GetAdderParameters(char*,unsigned int,unsigned int ,char*,unsigned int);
int Imop_SlopesPostProcessorList_InsertScaler(char*,unsigned int,unsigned int ,char*,float );
int Imop_SlopesPostProcessorList_GetScalerParameters(char*,unsigned int,unsigned int ,char*,float*);
int Imop_SlopesPostProcessorList_InsertPerfectLens(char*,unsigned int,unsigned int ,float ,unsigned char);
int Imop_SlopesPostProcessorList_GetPerfectLensParameters(char*,unsigned int,unsigned int ,float*,unsigned char*);
int Imop_SlopesPostProcessorList_InsertDoublePath(char*,unsigned int,unsigned int ,unsigned char,unsigned char);
int Imop_SlopesPostProcessorList_GetDoublePathParameters(char*,unsigned int,unsigned int ,unsigned char*,unsigned char*);
int Imop_SlopesPostProcessorList_InsertNeighborExtension(char*,unsigned int,unsigned int );
int Imop_SlopesPostProcessorList_InsertShutOfBoundaries(char*,unsigned int,unsigned int ,unsigned int );
int Imop_SlopesPostProcessorList_GetShutOfBoundariesParameters(char*,unsigned int,unsigned int ,unsigned int*);
int Imop_SlopesPostProcessorList_InsertModulator(char*,unsigned int,unsigned int ,float ,float ,float ,float ,float ,float );
int Imop_SlopesPostProcessorList_GetModulatorParameters(char*,unsigned int,unsigned int ,float *,float *,float *,float *,float *,float *);
int Imop_SlopesPostProcessorList_InsertPupilFromIntensityApplier(char*,unsigned int,unsigned int ,float   );
int Imop_SlopesPostProcessorList_GetPupilFromIntensityApplierParameters(char*,unsigned int,unsigned int ,float *);
int Imop_HasoField_New(char*,unsigned int *,char*,unsigned int,unsigned int,double ,double*,unsigned char );
int Imop_HasoField_Delete(char*,unsigned int);
int Imop_HasoField_GetWaveLength(char*,unsigned int,double*);
int Imop_HasoField_PSF(char*,unsigned int,unsigned char,unsigned char,float ,char *,unsigned int);
int Imop_HasoField_MTF(char*,unsigned int,char *,unsigned int);
int Imop_HasoField_Strehl(char*,unsigned int,char *,unsigned char,unsigned char,unsigned char,unsigned char,float ,float*);
int Imop_HasoField_StrehlFromPSF(char*,unsigned int,char *,unsigned int,unsigned int,unsigned char,float*);
int Imop_HasoField_GaussianParam(char*,char*,unsigned int,int   ,float*,float*,float*,float*,float*,char*,float );
int Imop_HasoField_CompleteGaussianParam(char*,char*,unsigned int,int   ,float*,float*,float*,float*,float*,char*,float ,float*,float*,unsigned int *,unsigned char*,float*);
int Imop_Diversity_Calibration();
int Imop_Diversity_ComputeZernikeCoeffs();
int Imop_Diversity_ProcessImage();
int Imop_Diversity_ComputeAverageRadius();
int Imop_Diversity_ComputeTF();
int Imop_Diversity_EncircledEnergy();
int Imop_Diversity_FullWidthAtKMaximum();
int Imop_HasoEngine_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_HasoEngine_Delete(char*,unsigned int);
int Imop_HasoEngine_AlignmentDataFromImage(char*,unsigned int,unsigned int,float2D*);
int Imop_HasoEngine_SetShift(char*,unsigned int,int2D*);
int Imop_HasoEngine_GetShift(char*,unsigned int,int2D*);
int Imop_HasoEngine_DoNewLens(char*,unsigned int);
int Imop_HasoEngine_SetAlgoType(char*,unsigned int,int );
int Imop_HasoEngine_GetAlgoType(char*,unsigned int,int *);
int Imop_HasoEngine_SetPreferences(char*,unsigned int,uint2D*,float );
int Imop_HasoEngine_GetPreferences(char*,unsigned int,uint2D*,float*);
int Imop_HasoEngine_ComputeSlopes(char*,unsigned int,unsigned int,unsigned int,unsigned char ,float*);
int Imop_WavefrontCorrector_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_WavefrontCorrector_Delete(char*,unsigned int);
int Imop_WavefrontCorrector_Init(char*,unsigned int,unsigned char);
int Imop_WavefrontCorrector_CallSpecificFeature(char*,unsigned int,char*);
int Imop_WavefrontCorrector_GetPreferences(char*,unsigned int,int *,float *,float *,int   *,float *);
int Imop_WavefrontCorrector_AssertEqualPreferences(char*,unsigned int,int     ,float *,float *,int   *,float *);
int Imop_WavefrontCorrector_CheckUserPreferences(char*,unsigned int,int     ,float *,float *,int   *,float *);
int Imop_WavefrontCorrector_SetPreferences(char*,unsigned int,int     ,float *,float *,int   *,float *);
int Imop_WavefrontCorrector_GetTemporization(char*,unsigned int,int *);
int Imop_WavefrontCorrector_SetTemporization(char*,unsigned int,int   );
int Imop_WavefrontCorrector_GetCurrentPositions(char*,unsigned int,float *);
int Imop_WavefrontCorrector_CheckRelativePositions(char*,unsigned int,float *);
int Imop_WavefrontCorrector_MoveToRelativePositions(char*,unsigned int,float *);
int Imop_WavefrontCorrector_CheckAbsolutePositions(char  *,unsigned int,float *);
int Imop_WavefrontCorrector_MoveToAbsolutePositions(char*,unsigned int,float *);
int Imop_WavefrontCorrector_ComputeDeltaCommandAmplitude(char*,unsigned int,float *,int *);
int Imop_WavefrontCorrector_GetActuatorPreferences(char*,unsigned int,int ,float *,float *,int   *,float *);
int Imop_WavefrontCorrector_CheckActuatorUserPreferences(char*,unsigned int,int ,float ,float ,int   ,float );
int Imop_WavefrontCorrector_SetActuatorPreferences(char*,unsigned int,int ,float ,float ,int   ,float );
int Imop_WavefrontCorrector_GetActuatorCurrentPosition(char*,unsigned int,int ,float *);
int Imop_WavefrontCorrector_CheckActuatorRelativePosition(char*,unsigned int,int ,float );
int Imop_WavefrontCorrector_MoveActuatorToRelativePosition(char*,unsigned int,int ,float );
int Imop_WavefrontCorrector_CheckActuatorAbsolutePosition(char  *,unsigned int,int ,float );
int Imop_WavefrontCorrector_MoveActuatorToAbsolutePosition(char*,unsigned int,int ,float );
int Imop_WavefrontCorrector_GetParameterInt(char*,unsigned int,char*,int *);
int Imop_WavefrontCorrector_GetParameterReal(char*,unsigned int,char*,double *);
int Imop_WavefrontCorrector_GetParameterBoolean(char*,unsigned int,char*,unsigned char*);
int Imop_WavefrontCorrector_GetParameterString(char*,unsigned int,char*,char*);
int Imop_WavefrontCorrector_SetParameterInt(char*,unsigned int,char*,int );
int Imop_WavefrontCorrector_SetParameterReal(char*,unsigned int,char*,double );
int Imop_WavefrontCorrector_SetParameterBoolean(char*,unsigned int,char*,unsigned char);
int Imop_WavefrontCorrector_SetParameterString(char*,unsigned int,char*,char*);
int Imop_WavefrontCorrector_GetPositionsFromFile(char*,char*,float *);
int Imop_WavefrontCorrector_SaveCurrentPositionsToFile(char*,unsigned int,char*);
int Imop_WavefrontCorrectorSet_NewFromConfigFile(char*,unsigned int *,char*);
int Imop_WavefrontCorrectorSet_Delete(char*,unsigned int);
int Imop_WavefrontCorrectorSet_GetSpecifications(char*,unsigned int,char*,char*,char*,int *,int *,int *,unsigned char*);
int Imop_WavefrontCorrectorSet_GetActuatorsCount(char*,unsigned int,int *);
int Imop_WavefrontCorrectorSet_GetInitialPreferences(char  *,unsigned int,float *,float *,int   *,float *,float *);
int Imop_WavefrontCorrectorSet_GetFlatMirrorPositions(char *,unsigned int,float*);
int Imop_WavefrontCorrectorSet_GetSpecificFeaturesListSize(char*,unsigned int,int*);
int Imop_WavefrontCorrectorSet_GetSpecificFeatureName(char*,unsigned int,int ,char*);
int Imop_WavefrontCorrectorSet_GetParameterListSize(char*,unsigned int,int*);
int Imop_WavefrontCorrectorSet_GetParameterName(char*,unsigned int,int ,char*);
int Imop_WavefrontCorrectorSet_GetParameterType(char*,unsigned int,char*,int*);
int Imop_WavefrontCorrectorSet_GetParameterOption(char*,unsigned int,char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*,unsigned char*);
int Imop_WavefrontCorrectorSet_GetParameterIntLimits(char*,unsigned int,char*,int*,int*);
int Imop_WavefrontCorrectorSet_GetParameterRealLimits(char*,unsigned int,char*,double*,double*);
int Imop_WavefrontCorrectorSet_GetAvailableValuesListSize(char*,unsigned int,char*,int*);
int Imop_WavefrontCorrectorSet_GetAvailableValue(char*,unsigned int,char*,unsigned int ,char*);
int Imop_WavefrontCorrectorSet_GetParameterIntDefaultValue(char*,unsigned int,char*,int*);
int Imop_WavefrontCorrectorSet_GetParameterBooleanDefaultValue(char*,unsigned int,char*,unsigned char*);
int Imop_WavefrontCorrectorSet_GetParameterRealDefaultValue(char*,unsigned int,char*,double*);
int Imop_WavefrontCorrectorSet_GetParameterStringDefaultValue(char*,unsigned int,char*,char*);
int Imop_WavefrontCorrectorSet_SaveSpecificationsAndPositionsToFile(char *,unsigned int,float *,char*);
