%   Imop_CameraSet_Delete                                               - CameraSet destructor
%   Imop_CameraSet_GetAvailableValue                                    - If parameter is a string to be selected among a finite set of strings, extract the possible value located at the index position from this set. see Imop_CameraSet_GetParameterOption.
%   Imop_CameraSet_GetAvailableValuesListSize                           - If parameter is a string to be selected among a finite set of strings, return the size of this set. see Imop_CameraSet_GetParameterOption
%   Imop_CameraSet_GetParameterBooleanDefaultValue                      - Camera parameter default value getter for parameter of type float.
%   Imop_CameraSet_GetParameterIntDefaultValue                          - Camera parameter default value getter for parameter of type integer.
%   Imop_CameraSet_GetParameterIntLimits                                - Camera parameter range getter for parameter of type integer.
%   Imop_CameraSet_GetParameterName                                     - Camera parameter name getter given its position in the parameters list.
%   Imop_CameraSet_GetParameterOption                                   - Camera parameter options getter given its name which should have been read with Imop_CameraSet_GetParameterName.
%   Imop_CameraSet_GetParameterRealDefaultValue                         - Camera parameter default value getter for parameter of type integer.
%   Imop_CameraSet_GetParameterRealLimits                               - Camera parameter range getter for parameter of type float.
%   Imop_CameraSet_GetParametersListSize                                - Camera parameters list size getter.
%   Imop_CameraSet_GetParameterStringDefaultValue                       - Camera parameter default value getter for parameter of type string.
%   Imop_CameraSet_GetParameterType                                     - Camera parameter type getter given its name which should have been read with Imop_CameraSet_GetParameterName.
%   Imop_CameraSet_GetSpecifications                                    - Camera specifications getter
%   Imop_CameraSet_GetSpecificFeatureName                               - Camera features name getter given its position in the parameters list.
%   Imop_CameraSet_GetSpecificFeaturesListSize                          - Camera features list size getter.
%   Imop_CameraSet_NewFromConfigFile                                    - CameraSet constructor
%   Imop_Camera_AsyncImageReady                                         - Indicates if a new image is available.
%   Imop_Camera_CallSpecificFeature                                     - Perform a camera action regarding its name.
%   Imop_Camera_Delete                                                  - Camera destructor
%   Imop_Camera_GetBackground                                           - Get Camera background image.
%   Imop_Camera_GetImage                                                - Retrieve last captured image. see Imop_Camera_AsyncImageReady
%   Imop_Camera_GetNbImagesToSum                                        - Get number of images to sum. Summing images makes the measured wavefront less sensitive to noise  (temporal average effect). Camera        Camera object adress.
%   Imop_Camera_GetParameterBoolean                                     - Camera parameter getter for parameter of type E_TYPE_BOOL.
%   Imop_Camera_GetParameterInt                                         - Camera parameter getter for parameter of type E_TYPE_INT.
%   Imop_Camera_GetParameterReal                                        - Camera parameter getter for parameter of type E_TYPE_REAL.
%   Imop_Camera_GetParameterString                                      - Camera parameter getter for parameter of type E_TYPE_STRING.
%   Imop_Camera_GetSequence                                             - Ask camera for array_size captures and retrieve images array (Synchronous mode - Blocking).
%   Imop_Camera_GetSize                                                 - Get Camera dimensions and depth.
%   Imop_Camera_GetState                                                - Get camera state : running or not, acquisition mode, synchronisation mode.
%   Imop_Camera_GetTimeOut                                              - Get Camera time out value.
%   Imop_Camera_IsHasoSensor                                            - Get Camera dimensions and depth.
%   Imop_Camera_NewFromConfigFile                                       - Camera constructor
%   Imop_Camera_SetBackground                                           - Set Camera background image. Image with substracted background can be retrieved using the Imop_Camera_GetLastImage function with remove_background_c = 1
%   Imop_Camera_SetNbImagesToSum                                        - Set number of images to sum Summing images makes the measured wavefront less sensitive to noise (temporal average effect). Camera        Camera object adress.
%   Imop_Camera_SetParameterBoolean                                     - Camera parameter setter for parameter of type E_TYPE_BOOL.
%   Imop_Camera_SetParameterInt                                         - Camera parameter setter for parameter of type E_TYPE_INT.
%   Imop_Camera_SetParameterReal                                        - Camera parameter setter for parameter of type E_TYPE_REAL.
%   Imop_Camera_SetParameterString                                      - camera parameter setter for parameter of type E_TYPE_STRING.
%   Imop_Camera_SetTimeOut                                              - Set Camera time out value.
%   Imop_Camera_SnapImage                                               - Snap Image using new acquisition mode and synchronous synchronization mode. There is no need of Starting and Stopping the camera manually with this method.
%   Imop_Camera_Start                                                   - Start acquisition
%   Imop_Camera_Stop                                                    - Stop acquisition.
%   Imop_Client_Delete                                                  - Client destructor
%   Imop_Client_GetBool                                                 - Boolean getter
%   Imop_Client_GetDataNameAndType                                      - Slopes getter
%   Imop_Client_GetDataNumber                                           - Slopes getter
%   Imop_Client_GetImage                                                - Slopes getter
%   Imop_Client_GetInt                                                  - Slopes getter
%   Imop_Client_GetReal                                                 - Slopes getter
%   Imop_Client_GetSlopes                                               - Slopes getter
%   Imop_Client_GetString                                               - Haso serial number getter
%   Imop_Client_New                                                     - Client constructor from server ip adress and server port.
%   Imop_ComputePhaseSet_Assignment                                     - Deep copy
%   Imop_ComputePhaseSet_Delete                                         - ComputePhaseSet Destructor
%   Imop_ComputePhaseSet_GetModalFilter                                 - Get filter for phase reconstruction from Modal decomposition. The filter is defined by the indices of polynomials that must be filtered. WARNING! ComputePhaseSet object type must not be E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputePhaseSet_GetTypePhase                                   - Get phase reconstruction type of the ComputePhaseSet object.
%   Imop_ComputePhaseSet_GetZonalFilter                                 - Get filter for zonal phase reconstruction. The filter is defined by the indices of array params that must be filtered. see Imop_ComputePhaseSet_GetLegendreFilter for details. WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputePhaseSet_GetZonalPrefs                                  - Get parameters for zonal phase reconstruction. WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputePhaseSet_NewFromCopy                                    - Imop_ComputePhaseSet constructor from copy
%   Imop_ComputePhaseSet_NewFromHasoData                                - Imop_ComputePhaseSet constructor from the processed slopes of a HasoData. Provide a pointer to a ComputePhaseSet object adress.
%   Imop_ComputePhaseSet_NewFromTypePhase                               - Imop_ComputePhaseSet constructor from E_COMPUTEPHASESET_T value. WARNING! See E_COMPUTEPHASESET_T for authorized values.
%   Imop_ComputePhaseSet_SetModalFilter                                 - Set filter for phase reconstruction from modal decomposition. The filter is defined by the indices of polynomials that must be filtered. WARNING! ComputePhaseSet object type must not be E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputePhaseSet_SetZonalFilter                                 - Set filter for zonal phase reconstruction. The aberrations to filter are selected using the boolean values in the params array. (0 = aberration is removed). - params[0] : tiltx - params[1] : tilty - params[2] : curvature - params[3] : astigmatism 0 degree - params[4] : astigmatism 45 degree WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputePhaseSet_SetZonalPrefs                                  - Set parameters for zonal phase reconstruction. WARNING! ComputePhaseSet object must be of type E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputeSlopes_CoefFromSlopes                                   - Compute modal coefficients that represent the processed slopes of the input Haso Data in a given basis of polynomials provided by ComputePhaseSet. WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL.
%   Imop_ComputeSlopes_PhaseModal                                       - Compute phase from slopes via modal coefficients in a given basis of polynomials provided by ComputePhaseSet. WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_LEGENDRE, E_COMPUTEPHASESET_MODAL_ZERNIKE.
%   Imop_ComputeSlopes_PhaseModalZonal                                  - Compute phase from slopes using both zonal and modal reconstruction. WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE. Computes phase from slopes thanks to an algorithm that combines the results of modal and zonal phase processors. It first computes modal coefficients in the requested polynomial basis using given modal preferences. From those coefficients, it reconstructs slopes. The difference HasoSlopes between input slopes and reconstructed slopes is called residual slopes. Output phase is obtained by summing modal phase obtained from modal coefficients using given modal parameters, and zonal phase obtained from residual slopes using zonal parameters consisting of given zonal preferences and a default-constructed zonal filter. Modal coeffs must have a projection pupil set : ComputePhaseSet     ComputePhaseSet object adress.
%   Imop_ComputeSlopes_PhaseModalZonalFromCoef                          - Compute phase from modal coefficients stored in ModalCoeffs given the preferences provided by ComputePhaseSet and adds the residual phase computed on input HasoSlopes using the modal + zonal reconstruction. Modal coeffs must have a projection pupil set in their preferences. WARNING! Allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE.
%   Imop_ComputeSlopes_PhaseZonal                                       - Compute phase from HasoSlopes. Filter some aberrations of reconstructed phase, depending on the filter given in zonal phase reconstruction parameters provided by ComputePhaseSet.
%   Imop_ComputeSlopes_SlopesFromCoef                                   - *Compute slopes from modal coefficients that represent them in a given basis of polynomials provided by ComputePhaseSet. Modal coeffs must have a projection pupil set in their preferences. WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_LEGENDRE, E_COMPUTEPHASESET_MODAL_ZERNIKE.
%   Imop_Compute_CoefFromHasoData                                       - Compute modal coefficients that represent the processed slopes of the input Haso Data in a given basis of polynomials provided by ComputePhaseSet. WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL.
%   Imop_Compute_PhaseFromCoef                                          - Compute phase from modal coefficients in a given basis of polynomials provided by ComputePhaseSet. WARNING! allowed ComputePhaseSet types : all but E_COMPUTEPHASESET_ZONAL. Modal coeffs must have a projection pupil set : ComputePhaseSet  ComputePhaseSet object adress.
%   Imop_Compute_PhaseModal                                             - Compute phase from processed slopes of the input HasoData via modal coefficients in a given basis of polynomials provided by ComputePhaseSet. WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_LEGENDRE, E_COMPUTEPHASESET_MODAL_ZERNIKE.
%   Imop_Compute_PhaseModalZonal                                        - Compute phase from slopes using both zonal and modal reconstruction. WARNING! allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE. Computes phase from slopes thanks to an algorithm that combines the results of modal and zonal phase processors. It first computes modal coefficients in the requested polynomial basis using given modal preferences. From those coefficients, it reconstructs slopes. The difference HasoSlopes between processed slopes of the input HasoData and reconstructed slopes is called residual slopes. Output phase is obtained by summing modal phase obtained from modal coefficients using given modal parameters, and zonal phase obtained from residual slopes using zonal parameters consisting of given zonal preferences and a default-constructed zonal filter. Modal coeffs must have a projection pupil set : ComputePhaseSet  ComputePhaseSet object adress.
%   Imop_Compute_PhaseModalZonalFromCoef                                - Not available WARNING! Allowed ComputePhaseSet types : E_COMPUTEPHASESET_MODAL_ZONAL_ZERNIKE, E_COMPUTEPHASESET_MODAL_ZONAL_LEGENDRE. Compute phase from modal coefficients stored in ModalCoeffs given the preferences provided by ComputePhaseSet and adds the residual phase computed on processed slopes of the input HasoData using the modal + zonal reconstruction. Modal coeffs must have a projection pupil set in their preferences. ComputePhaseSet     ComputePhaseSet object adress.
%   Imop_Compute_PhaseZonal                                             - Compute phase from processed slopes of the input HasoData. Filter some aberrations of reconstructed phase, depending on the filter given in zonal phase reconstruction parameters provided by ComputePhaseSet. ComputePhaseSet  ComputePhaseSet object adress.
%   Imop_CoreEngine_GetCameraPluginName                                 - Not available
%   Imop_CoreEngine_GetConfig                                           - Haso configuration information getter.
%   Imop_CoreEngine_GetFocalCamConfig                                   - Not available
%   Imop_CoreEngine_GetSDKConfig                                        - Not available
%   Imop_CoreEngine_GetSerialNumber                                     - Not available
%   Imop_CoreEngine_GetSoftwareConfig                                   - Not available
%   Imop_CoreEngine_GetWavefrontCorrectorPluginName                     - Not available
%   Imop_CoreEngine_IsHasoConfigFile                                    - Not available
%   Imop_CorrDataManager_ApplyPupilMask                                 - Modifies the greatest common pupil Sets the greatest common pupil to the intersection between itself and the pupil_mask. If the pupil_mask has more "1" values than the current greatest common pupil, it won't have any effect on it (Reduce pupil size only). corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_CheckRelativePositionsSaturation               - Count the number of actuators which will be saturated (reaching min or max of their positions) if relative command is applied
%   Imop_CorrDataManager_ComputeClosedLoopIteration                     - Compute the commands associated to one closed-loop iteration targeting delta_slopes. This function is quite similar to Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes. The difference is that the computed delta command takes the provided smoothing parameters and specified gain into account. The real loop gain applied on computed delta command is returned via the applied_loop_gain. corrdata_manager     CorrDataManager object adress.
%   Imop_CorrDataManager_ComputeCommandMatrix                           - Computes command matrix.
%   Imop_CorrDataManager_ComputeDeltaCommandFromDeltaSlopes             - Compute the relative wavefront corrector commands corresponding to a delta_slopes variation. This function uses the CorrDataManager command matrix and wavefront corrector preferences to compute the output command. Typical application is to compute the delta slopes as the difference between the current measured slopes and references slopes (for example, references slopes can be created from a particular set of Zernike coefficients, see Imop_HasoSlopes_NewFromModalCoef). corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_ComputeInteractionMatrix                       - Compute interaction matrix from collected calibration data (two HasoSlopes measured per actuator). WARNING! Calibration HasoSlopes associated to an invalid actuator must be valid HasoSlopes objects anyway and not NULL pointers.
%   Imop_CorrDataManager_ComputeSlopesFromCommand                       - Simulation of the expected slopes given a wavefront corrector command. Function returns an error if command is not compliant with the current corrdata_manager wavefront corrector preferences. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_Delete                                         - CorrDataManager copy destructor.
%   Imop_CorrDataManager_GetActuatorInfluence                           - Get actuator influence as HasoSlopes The influence pupil may be the pupil where actuator influence has been computed or the greatest common pupil of all the actuators (CorrDataManager greatest common pupil). Returns 0 HasoSlopes if actuator in not valid. corrdata_manager    CorrDataManager object adress.
%   Imop_CorrDataManager_GetActuatorPrefs                               - Preferences getter for one wavefront corrector actuator.
%   Imop_CorrDataManager_GetActuatorsCount                              - Wavefront corrector actuators number getter.
%   Imop_CorrDataManager_GetCalibrationCommands                         - Get the two wavefront corrector commands corresponding to the actuator actuator_index calibration. Command application must be performed using the functions of WFC. Corresponding WFC must be computed on appropriate WFC captured by the Haso sensor, Function returns an error if actuator is invalid. If so, please do not move the actuator and continue with the next one. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_GetCalibrationMatrixSize                       - Calibration matrix size getter.
%   Imop_CorrDataManager_GetCommandMatrixBuffer                         - Command matrix content getter.
%   Imop_CorrDataManager_GetCommandMatrixSize                           - Command matrix size getter.
%   Imop_CorrDataManager_GetCorrectorInitPrefs                          - Wavefront corrector actuators preferences getter.
%   Imop_CorrDataManager_GetCorrectorPrefs                              - Wavefront corrector actuators preferences getter.
%   Imop_CorrDataManager_GetDiagnosticEigenVectors                      - Get HasoSlopes object and commands array associated to an influence.
%   Imop_CorrDataManager_GetDiagnosticSingularVector                    - Get vector of singular values.
%   Imop_CorrDataManager_GetGreatestCommonPupil                         - Computes the greatest common pupil
%   Imop_CorrDataManager_GetInteractionMatrixBuffer                     - Interaction matrix content getter.
%   Imop_CorrDataManager_GetInteractionMatrixSize                       - Interaction matrix size getter.
%   Imop_CorrDataManager_GetSpecifications                              - Haso and Wavefront corrector specifications getter.
%   Imop_CorrDataManager_LoadBackupFile                                 - Load data extracted from a CorrDataManager backup file into current CorrDataManager object.
%   Imop_CorrDataManager_NewFromBackupFile                              - CorrDataManager constructor from a CorrDataManager dump file.
%   Imop_CorrDataManager_NewFromConfigsFiles                            - CorrDataManager constructor from a Haso configuration file and a wavefront configuration file.
%   Imop_CorrDataManager_NewFromCopy                                    - CorrDataManager copy constructor.
%   Imop_CorrDataManager_RemovePupilMask                                - Restore the greatest common pupil Cancel the effects of pupil mask(s) : Restore the greatest common pupil to last interaction matrix computation value or last loading from a backup value. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_ResetInteractionMatrix                         - Reset Interaction matrix, greatest common pupil and Wavefront corrector preferences to the last stable state. WARNING! This function clears command matrix and diagnostics. Restore the CorrDataManager to last interaction matrix computation state or last loading from a backup file. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_SaveBackupFile                                 - Dumps CorrDataManager data to file.
%   Imop_CorrDataManager_SetActuatorPrefs                               - Preferences setter for one wavefront corrector actuator. The new preferences have to be compliant with the Wavefront corrector specifications (read from configuration file). If the new preferences are compliant with the one used for the last calibration process or the last loaded ones, the interaction matrix is recomputed, else the interaction matrix is erased and a new calibration process (or loading from file or backup restoration) is needed. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_SetCalibrationPrefs                            - Calibration process supposes back and forth moves on all actuators. Use this function to calibrate the amplitude of these moves. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_SetCommandMatrixPrefs                          - Command matrix computation preferences.
%   Imop_CorrDataManager_SetCorrectorPrefs                              - Wavefront corrector actuators preferences setter. The new preferences have to be compliant with the Wavefront corrector specifications (read from configuration file). If the new preferences are compliant with the one used for the last calibration process or the last loaded ones, the interaction matrix is recomputed, else the interaction matrix is erased and a new calibration process (or loading from file or backup restoration) is needed. corrdata_manager  CorrDataManager object adress.
%   Imop_CorrDataManager_SetMicrolensesFocalLength                      - Micro lenses focal length setter.Provided for backward compatibility with old formatted interaction matrix backup files. This value is used for correction loop computations. If a focal length value has already been set in the correction data manager, it won't be replaced.
%   Imop_CorrDataManager_UpdateInteractionMatrix                        - Update interaction matrix from two HasoSlopes resulting of one calibration step for actuator index.
%   Imop_Diversity_Calibration                                          - Not available
%   Imop_Diversity_ComputeAverageRadius                                 - Not available
%   Imop_Diversity_ComputeTF                                            - Not available
%   Imop_Diversity_ComputeZernikeCoeffs                                 - Not available
%   Imop_Diversity_EncircledEnergy                                      - Not available
%   Imop_Diversity_FullWidthAtKMaximum                                  - Not available
%   Imop_Diversity_ProcessImage                                         - Not available
%   Imop_FakeInterface                                                  - Not available
%   Imop_GetDriversError                                                - Not available
%   Imop_GetDriversErrorSize                                            - Not available
%   Imop_GetModuleVersion                                               - Not available
%   Imop_HasoData_ApplySlopesPostProcessorList                          - Apply a SlopesPostProcessorList to the raw HasoSlopes stores in the HasoData object.
%   Imop_HasoData_Assignment                                            - HasoData deep copy.
%   Imop_HasoData_Delete                                                - HasoData destructor.
%   Imop_HasoData_GetComputePhaseMode                                   - Not available Get phase reconstruction mode. HasoData     HasoData object adress.
%   Imop_HasoData_GetComputePhaseParameters                             - Not available WARNING! allowed E_COMPUTEPHASESET_T value : Any. Get ComputePhaseSet object. HasoData         HasoData object adress.
%   Imop_HasoData_GetDimensionsAndSteps                                 - Get HasoData dimensions and steps
%   Imop_HasoData_GetHasoSlopes                                         - Get raw and processed HasoSlopes objects.
%   Imop_HasoData_GetInfo                                               - Get informations from HasoData object.
%   Imop_HasoData_GetInfoFromHasFile                                    - Get informations from .has file.
%   Imop_HasoData_GetProcessorList                                      - SlopesPostProcessorList getter.
%   Imop_HasoData_GetSequence                                           - Load a HasoData array from file.
%   Imop_HasoData_GetSequenceSize                                       - Get the size of the HasoData array from file.
%   Imop_HasoData_New                                                   - HasoData constructor from HasoSlopes
%   Imop_HasoData_NewFromCopy                                           - HasoData constructor from copy.
%   Imop_HasoData_NewFromFile                                           - HasoData constructor from a .has file. If file opening fails, an exception is thrown.
%   Imop_HasoData_ResetToRawData                                        - Reset slopes to their raw state and clear process history.
%   Imop_HasoData_Save                                                  - Saves a HasoData object to a .has file. If file already exists, it is overwritten, provided that opening succeeds. If file opening fails, an exception is thrown.
%   Imop_HasoData_SetComputePhaseParameters                             - Set ComputePhaseSet object. WARNING! allowed E_COMPUTEPHASESET_T value :  Any.
%   Imop_HasoData_SetHasoSlopes                                         - Set raw HasoSlopes objects.
%   Imop_HasoData_SetWaveLength                                         - Set source wavelength.
%   Imop_HasoEngine_AlignmentDataFromImage                              - During optical centering process, computes the barycenter coordinates in pixels of the visible spots on the Haso sensor. The optical system is aligned when these coordinates are close to the alignment_position_pixels (error < tolerance_radius). WARNING! The centering device must be mounted on the Haso sensor.
%   Imop_HasoEngine_ComputeSlopes                                       - Compute HasoSlopes. Please check that parameters have been set, and alignment step is completed.
%   Imop_HasoEngine_Delete                                              - HasoEngine destructor.
%   Imop_HasoEngine_DoNewLens                                           - Reset spots detection. In particular, reinitialize the spots tracking.
%   Imop_HasoEngine_GetAlgoType                                         - Spots detection algorithm type getter.
%   Imop_HasoEngine_GetPreferences                                      - HasoSlopes computation parameters getter.
%   Imop_HasoEngine_GetShift                                            - Get the shift values (in x and y direction) to apply to pair the start sub-pupil with the appropriate micro-lens.
%   Imop_HasoEngine_NewFromConfigFile                                   - HasoEngine constructor from a Haso configuration file.
%   Imop_HasoEngine_SetAlgoType                                         - Spots detection algorithm type setter.
%   Imop_HasoEngine_SetPreferences                                      - HasoSlopes computation parameters setter.
%   Imop_HasoEngine_SetShift                                            - *Not available Set the shift values (in x and y direction) to apply to pair the start sub-pupil with the appropriate micro-lens. HasoEngine   HasoEngine object adress.
%   Imop_HasoField_CompleteGaussianParam                                - Complete gaussian parameters function This function computes gaussian parameters of a beam from a HasoField. Input HasoField is used to compute values of the point spread function (PSF) over different computation planes. The number of computation planes can be set by user. The different computation planes constitute the computation data, which can be got after processing. In a given computation plane, the PSF forms a spot which can be approximated by a circle or a square whose size plays a role for gaussian parameters determination. By default, the function is configured to use circular spots, but it can be configured to use tilted square spots. The square's tilt is defined by the angle it forms with an horizontal axis. When the processor is configured to use circular spots, it characterizes the circle by its radius. When the processor is configured to use square spots, it characterizes the square by the half length of its side. In both cases, this quantity is stored in attribute spot_size of corresponding ComputationPlane instance. config_file_path            Absolute path to the Haso configuration file.
%   Imop_HasoField_Delete                                               - HasoField destructor.
%   Imop_HasoField_GaussianParam                                        - Gaussian parameters function This function computes gaussian parameters of a beam from a HasoField. Input HasoField is used to compute values of the point spread function (PSF) over different computation planes. The number of computation planes can be set by user. The different computation planes constitute the computation data, which can be got after processing. In a given computation plane, the PSF forms a spot which can be approximated by a circle or a square whose size plays a role for gaussian parameters determination. By default, the function is configured to use circular spots, but it can be configured to use tilted square spots. The square's tilt is defined by the angle it forms with an horizontal axis. When the processor is configured to use circular spots, it characterizes the circle by its radius. When the processor is configured to use square spots, it characterizes the square by the half length of its side. In both cases, this quantity is stored in attribute spot_size of corresponding ComputationPlane instance. config_file_path            Absolute path to the Haso configuration file.
%   Imop_HasoField_GetWaveLength                                        - Get the wavelength of the source.
%   Imop_HasoField_MTF                                                  - Modulation transfer function from point spread function surface
%   Imop_HasoField_New                                                  - HasoField constructor from HasoSlopes and phase HasoSlopes provides slopes pupil, and HasoSlopes provides a pupil which is expected to be equal to slopes pupil or to the greatest common pupil between slopes pupil and a projection pupil used for HasoSlopes computation. This implies that pupil of HasoSlopes must be included in pupil of HasoSlopes. After checking this is the case, function uses the pupil of HasoSlopes for resulting HasoSlopes. It is possible to oversample the resulting field: each increment of oversampling_level doubles the field's size. haso_config_file_path  Absolute path to Haso configuration file.
%   Imop_HasoField_PSF                                                  - Point spread function This function computes point spread function from a HasoField. The function allows to choose the defocus which is zero by default. It also provides options to use null phase instead of measured phase, and flat intensity instead of measured intensity. When using a null phase, phase contained in input HasoField is not used. When using a flat intensity, intensity contained in input HasoField is used anyway, as well as pupil, to compute average intensity. HasoField         HasoField object adress.
%   Imop_HasoField_Strehl                                               - Strehl ratio from HasoField function This function computes Strehl ratio from a HasoField. Input HasoField is used to compute experimental and theoretical point spread functions (PSF). The function allows to choose the defocus. It also provides options to use flat intensity instead of measured intensity for computation of experimental or theoretical PSF. Another option is available to compute Strehl ratio through focus, in which case theoretical PSF is computed in the same place as experimental PSF rather than at focal point. There is also an option to oversample PSF surfaces before ratio computation. HasoField                    HasoField object adress.
%   Imop_HasoField_StrehlFromPSF                                        - Strehl ratio from PSF function This function Strehl ratio from experimental and theoretical point spread functions (PSF). There is also an option to oversample both PSF surfaces before ratio computation. HasoField         HasoField object adress.
%   Imop_HasoSlopes_Assignment                                          - HasoSlopes deep copy.
%   Imop_HasoSlopes_Delete                                              - HasoSlopes destructor
%   Imop_HasoSlopes_Filter                                              - Not available WARNING! Slopes filtering is not based on polynomial decomposition (Zernike or Legendre). Computed Phase based on filtered slopes then can differ from computed then filtered Phase depending on the chosen phase reconstruction algorithm. Please consider using Slopes filtering for AO target creation and Phase filtering for display. Filter the HasoSlopes input. Remove : - Z1 = ax*m_X + bx*m_Y + cx from x slopes, - Z2 = ay*m_X + by*m_Y + cy from y slopes. HasoSlopes            HasoSlopes object adress.
%   Imop_HasoSlopes_GetGeometricProperties                              - Compute HasoSlopes geometric properties.
%   Imop_HasoSlopes_GetInfo                                             - HasoSlopes specifications getter.
%   Imop_HasoSlopes_GetIntensity                                        - HasoSlopes intensity buffer getter.
%   Imop_HasoSlopes_GetPupilBuffer                                      - HasoSlopes pupil buffer getter.
%   Imop_HasoSlopes_GetPupilPointer                                     - HasoSlopes pointer to pupil object getter.
%   Imop_HasoSlopes_GetSlopesX                                          - HasoSlopes X buffer getter.
%   Imop_HasoSlopes_GetSlopesY                                          - HasoSlopes Y buffer getter.
%   Imop_HasoSlopes_HasAliasing                                         - Test whether HasoSlopes causes aliasing When Phase has been reconstructed from slopes, strong local extrema on slopes may provoke aliasing. This function allows to test whether slopes will produce suitable phase for correct gaussian parameters computation. Source wavelength must be available in metadata of input Haso slopes. The radius of curvature of the slopes, in millimeters, is required to perform the test. HasoSlopes           HasoSlopes object adress.
%   Imop_HasoSlopes_NewFromConfigFile                                   - HasoSlopes constructor from Haso configuration file
%   Imop_HasoSlopes_NewFromCopy                                         - HasoSlopes constructor from copy
%   Imop_HasoSlopes_NewFromDimensions                                   - HasoSlopes constructor from dimensions and steps
%   Imop_HasoSlopes_NewFromHasFile                                      - HasoSlopes constructor from .has file
%   Imop_HasoSlopes_NewFromHasoData                                     - HasoSlopes constructor from Haso configuration file
%   Imop_HasoSlopes_NewFromImage                                        - HasoSlopes constructor from HasoSlopes. This constructor computes the slopes on the input Image object and creates the corresponding HasoSlopes object. The slopes computation core (HasoEngine) parameters are all set to their default values and cannot be modified, excepting the start sub-pupil coordinates. If no start sub-pupil coordinates are provided, default values from configuration file are used. Image             Image object adress.
%   Imop_HasoSlopes_NewFromModalCoef                                    - HasoSlopes constructor from HasoSlopes. This constructor computes the slopes on the input ModalCoef using the type of reconstruction and projection pupil defined in it (Legendre or Zernike) and creates the corresponding HasoSlopes object. Modal coeffs must have a projection pupil set in their preferences. ModalCoef         ModalCoef object adress.
%   Imop_HasoSlopes_SaveToFile                                          - Save HasoSlopes to a .has file.
%   Imop_HasoSlopes_SetIntensity                                        - HasoSlopes intensity buffer setter.
%   Imop_HasoSlopes_SetPupil                                            - HasoSlopes pupil object content setter.
%   Imop_HasoSlopes_SetSlopesX                                          - HasoSlopes X buffer setter.
%   Imop_HasoSlopes_SetSlopesY                                          - HasoSlopes Y buffer setter.
%   Imop_HasoSlopes_SetWaveLength                                       - HasoSlopes wavelength setter.
%   Imop_Haso_DLLVersion                                                - Not available
%   Imop_Image_Assignment                                               - Deep copy : copy ImageB content to ImageA. Images must have the same size, channels count and bits depth.
%   Imop_Image_Delete                                                   - Image destructor.
%   Imop_Image_GetAcquisitionInfo                                       - Get acquisition information from Image object.
%   Imop_Image_GetData                                                  - Get pixels buffer as an unsigned int array. This function wraps the specialized ones (GetDataU8 / GetDataU16 / GetDataU32). to provide a simplified access to pixels values (no bit depth check needed). Image        Image object adress.
%   Imop_Image_GetDataU16                                               - Get pixels buffer from 16-bit unsigned Image. Provided for refined memory handling. Image        Image object adress.
%   Imop_Image_GetDataU32                                               - Get pixels buffer from 32-bit unsigned Image. Provided for refined memory handling. Image        Image object adress.
%   Imop_Image_GetDataU8                                                - Get pixels buffer from 8-bit unsigned Image. Provided for refined memory handling. Image        Image object adress.
%   Imop_Image_GetHasoSerialNumber                                      - Get Haso serial number from Image object if Image has been captured with a Haso sensor, else return an error.
%   Imop_Image_GetInfo                                                  - Get metadata from Image object.
%   Imop_Image_GetInfo_FromFile                                         - Get acquisition information from image file.
%   Imop_Image_GetSize                                                  - Get Image size.
%   Imop_Image_GetStatistics                                            - Statistics Compute : - The average of the nb_extreme_pixels greatest elements. - The average of the nb_extreme_pixels smallest elements. - The percentage of saturated pixels. Image              Image object adress.
%   Imop_Image_IsHasoImage                                              - Check if Image has been captured with a Haso sensor.
%   Imop_Image_Load                                                     - Load Image from file.
%   Imop_Image_New                                                      - Single channel Image constructor from dimensions and bit depth.
%   Imop_Image_NewCustom                                                - Image constructor from custom data : dimensions, camera serial number, acquisition information, buffer of data. Maximum value in buffer is assessed against the bit depth of the image. Please make sure buffer and image dimensions are coherent.
%   Imop_Image_NewFromConfig                                            - Not available
%   Imop_Image_NewFromFile                                              - Image constructor from file.
%   Imop_Image_NewFromSubtraction                                       - Image constructor from a subtraction of two images : (new) image = imageA - imageB
%   Imop_Image_Save                                                     - Save Image to file.
%   Imop_Image_SetData                                                  - Set pixels buffer as an unsigned int array. Maximum value in buffer is assessed against the bit depth of the image. Please make sure buffer and image dimensions are coherent. buffer       Pixel buffer.
%   Imop_Image_SubtractionAB                                            - Inplace subtraction : ImageA = ImageA - ImageB. Images must have the same size, channels count and bits depth.
%   Imop_Image_SubtractionABC                                           - Subtraction : Image = ImageA - ImageB. Images must have the same size, channels count and bits depth.
%   Imop_Intensity_Delete                                               - Intensity destructor
%   Imop_Intensity_GetData                                              - Intensity values buffer and pupil getter.
%   Imop_Intensity_GetDimensionsAndSteps                                - Get Intensity dimensions
%   Imop_Intensity_GetStatistics                                        - Compute statistics on Intensity
%   Imop_Intensity_NewFromDimAndSteps                                   - Intensity constructor from dimensions and steps. All the elements of the Phase values buffer are set to zero and the elements of the pupil are set to true. dimensions   Intensity dimensions as the (width, height) of the pupil.
%   Imop_Intensity_NewFromSlopes                                        - Intensity constructor from HasoSlopes. Extract intensity values from HasoSlopes object and builds Intensity object
%   Imop_Intensity_Resize                                               - Resize and interpolate Intensity
%   Imop_Intensity_SetData                                              - Intensity values buffer and pupil setter.
%   Imop_LoopSecurityActivation_Delete                                  - Destruction
%   Imop_LoopSecurityActivation_Get                                     - get switches states
%   Imop_LoopSecurityActivation_New                                     - Manual construction
%   Imop_LoopSecurityActivation_NewHigh                                 - Construction from Imagine Optic recommended high security activations
%   Imop_LoopSecurityActivation_NewLow                                  - Construction from Imagine Optic recommended low security activations
%   Imop_LoopSecurityActivation_NewMedium                               - Construction from Imagine Optic recommended medium security activations
%   Imop_LoopSecurityActivation_Set                                     - set switches states
%   Imop_LoopSecurityParams_Delete                                      - Destruction
%   Imop_LoopSecurityParams_Get                                         - get tolerances
%   Imop_LoopSecurityParams_New                                         - Manual construction
%   Imop_LoopSecurityParams_NewHigh                                     - Construction from Imagine Optic recommended high security parameters
%   Imop_LoopSecurityParams_NewLow                                      - Construction from Imagine Optic recommended low security parameters
%   Imop_LoopSecurityParams_NewMedium                                   - Construction from Imagine Optic recommended medium security parameters
%   Imop_LoopSecurityParams_Set                                         - set tolerances
%   Imop_LoopSecurity_Check                                             - Perform security checks required by security_activation using security_params values.
%   Imop_LoopSecurity_CheckHigh                                         - Perform security checks using Imagine Optic recommended high security switches settings and parameters.
%   Imop_LoopSecurity_CheckLow                                          - Perform security checks using Imagine Optic recommended low security switches settings and parameters.
%   Imop_LoopSecurity_CheckMedium                                       - Perform security checks using Imagine Optic recommended medium security switches settings and parameters.
%   Imop_LoopSmoothingParams_ComputeGainFactor                          - Compute value of smoothing gain as a decreasing function of delta command amplitude This function is called in the Imop_CorrDataManager_ComputeClosedLoopIteration function, where the applied_loop_gain is computed as the product of the computed factor and the specified_loop_gain. smoothing_params  Closed Loop smoothing params object adress.
%   Imop_LoopSmoothingParams_Delete                                     - loop smoothing parameters destructor
%   Imop_LoopSmoothingParams_Get                                        - Get closed loop smoothing parameters
%   Imop_LoopSmoothingParams_New                                        - loop smoothing parameters constructor
%   Imop_LoopSmoothingParams_NewHigh                                    - loop smoothing parameters constructor : Smooth a lot
%   Imop_LoopSmoothingParams_NewLow                                     - loop smoothing parameters constructor : Don't smooth
%   Imop_LoopSmoothingParams_NewMedium                                  - loop smoothing parameters constructor : Smooth a little
%   Imop_LoopSmoothingParams_Set                                        - Set closed loop smoothing parameters
%   Imop_ModalCoef_Assignment                                           - ModalCoef deep copy.
%   Imop_ModalCoef_Delete                                               - ModalCoef Destructor
%   Imop_ModalCoef_GetData                                              - Get polynomial coefficients informations and values.
%   Imop_ModalCoef_GetDim                                               - Retrieve polynomial coefficients count.
%   Imop_ModalCoef_GetLegendrePrefs                                     - Get preferences for phase projection from Legendre decomposition. WARNING! ModalCoef object must be of type E_MODALCOEF_LEGENDRE
%   Imop_ModalCoef_GetType                                              - Retrieve polynomial coefficients type.
%   Imop_ModalCoef_GetTypeFromFile                                      - Retrieve polynomial coefficients type from file (no modal coefficient object needed).
%   Imop_ModalCoef_GetZernikePrefs                                      - Get preferences for phase projection from Zernike decomposition. WARNING! ModalCoef object must be of type E_MODALCOEF_ZERNIKE
%   Imop_ModalCoef_New                                                  - ModalCoef constructor
%   Imop_ModalCoef_NewFromCopy                                          - ModalCoef constructor from copy
%   Imop_ModalCoef_NewFromData                                          - ModalCoef constructor from reconstruction informations WARNING! This method does not set the ModalCoef preferences.
%   Imop_ModalCoef_NewFromFile                                          - ModalCoef constructor from modal coefficients file
%   Imop_ModalCoef_NewLegendreFromSlopes                                - ModalCoef constructor from slopes object. Uses the auto-detected square inscribed pupil. WARNING! This method does not handle central occulation and returns the nb_coeffs_total first Legendre coefficients unfiltered.
%   Imop_ModalCoef_NewZernikeFromSlopes                                 - ModalCoef constructor from slopes object. Uses the auto-detected circular inscribed pupil. WARNING! This method does not handle central occulation and returns the nb_coeffs_total first Zernike coefficients unfiltered.
%   Imop_ModalCoef_SetData                                              - Set polynomial coefficients informations and values.
%   Imop_ModalCoef_SetLegendrePrefs                                     - Set the Legendre preferences for modal phase projection. WARNING! ModalCoef object must be of type E_MODALCOEF_LEGENDRE
%   Imop_ModalCoef_SetZernikePrefs                                      - Set the Zernike preferences for modal phase projection. WARNING! ModalCoef object must be of type E_MODALCOEF_ZERNIKE
%   Imop_Phase_Delete                                                   - Phase destructor
%   Imop_Phase_GetData                                                  - Phase values buffer and pupil getter.
%   Imop_Phase_GetDimensionsAndSteps                                    - Get Phase dimensions
%   Imop_Phase_GetPupil                                                 - Phase pupil getter.
%   Imop_Phase_GetStatistics                                            - Compute statistics on Phase
%   Imop_Phase_NewFromDimAndSteps                                       - Phase constructor from dimensions and steps. All the elements of the Phase values buffer are set to zero and the elements of the pupil are set to true. dimensions   Phase dimensions as the (width, height) of the pupil.
%   Imop_Phase_NewFromModalCoef                                         - Phase constructor from Phase. This constructor computes the slopes on the input Phase object depending on the projection type (Legendre or Zernike) and number of coefficients, then it computes the Phase and creates the corresponding Phase object. The slopes computation and Phase reconstruction parameters (ComputePhaseSet) are all set to their default values and cannot be modified. Modal coeffs must have a projection pupil set in their preferences. ModalCoef    ModalCoef object adress.
%   Imop_Phase_NewFromPupil                                             - Phase constructor from pupil
%   Imop_Phase_NewFromSlopes                                            - Phase constructor from HasoSlopes. This constructor computes the Phase using the selected method : 1 = Modal reconstruction, Legendre basis 2 = Modal reconstruction, Zernike basis 3 = Zonal reconstruction and creates the corresponding Phase object. The Phase reconstruction parameters (ComputePhaseSet) are all set to their default values and cannot be modified, except the aberration filter (0 = aberration is removed) and the number of coefficients to be used for modal reconstructions (before filtering). The correspondance between aberrations and polynomial modes (Modal reconstructions only) is automatically computed. - filter[0] : tiltx - filter[1] : tilty - filter[2] : curvature - filter[3] : astigmatism 0 degree - filter[4] : astigmatism 45 degree The projection pupil (Modal reconstructions only) is automatically computed from the slopes natural pupil.
%   Imop_Phase_Resize                                                   - Resize and interpolate Phase
%   Imop_Phase_SetData                                                  - Phase values buffer and pupil setter.
%   Imop_PupilCompute_ApplyNeighborExtension                            - Applies a "NeighborExtension" (Fill) to a Pupil object.
%   Imop_PupilCompute_ApplyShutOfBoundaries                             - Applies a "ShutOfBoundaries" (Erosion) to a Pupil object.
%   Imop_PupilCompute_FillOccultations                                  - Compute a pupil with no holes in it (for example, central occultation case). If pupil_in is 0 0 0 0 0 0 1 1 1 0 1 1 0 1 1 0 1 1 1 0 0 0 0 0 0 pupil_out will be 0 0 0 0 0 0 1 1 1 0 1 1 1 1 1 0 1 1 1 0 0 0 0 0 0 The difference with Imop_PupilCompute_ApplyNeighborExtension is that there is no constraint on the occultations size. Pupil_in     pupil object adress.
%   Imop_PupilCompute_FitLegendrePupil                                  - Compute the geometric parameters of the Legendre pupil from a pupil input. This function is not parameterizable. It takes a user pupil as input and detects a square pupil that is as large as possible and entirely inside it. If several pupils with the same size suit, one of them is chosen arbitrarily. Pupil        pupil object adress.
%   Imop_PupilCompute_FitZernikePupil                                   - Compute the geometric parameters of the Zernike pupil from a pupil input.
%   Imop_Pupil_AND                                                      - AND operator.
%   Imop_Pupil_Assignment                                               - Deep copy.
%   Imop_Pupil_Delete                                                   - Pupil destructor.
%   Imop_Pupil_GetBarycenter                                            - Get Pupil barycenter.
%   Imop_Pupil_GetData                                                  - Get Pupil buffer.
%   Imop_Pupil_GetDimensions                                            - Get Pupil dimensions and steps.
%   Imop_Pupil_GetNbEnlightedSubapertures                               - Get Pupil enlighted subapertures number
%   Imop_Pupil_HasCentralOccultation                                    - Find if pupil has one or more central occultation(s).
%   Imop_Pupil_INVERT                                                   - INVERT operator.
%   Imop_Pupil_NewFromCopy                                              - Pupil constructor from copy
%   Imop_Pupil_NewFromDimensions                                        - Pupil constructor from dimensions, steps and inital value.
%   Imop_Pupil_NewFromHasoSlopes                                        - Pupil constructor from HasoSlopes.
%   Imop_Pupil_NewFromLegendrePupil                                     - Rectangular Pupil constructor from dimensions, steps and rectangle shape.
%   Imop_Pupil_NewFromZernikePupil                                      - Circular Pupil constructor from dimensions, steps and circle shape.
%   Imop_Pupil_OR                                                       - OR operator.
%   Imop_Pupil_RegionsStats                                             - Get statistics on pupil regions
%   Imop_Pupil_Resize                                                   - Resize pupil.
%   Imop_Pupil_SetData                                                  - Set Pupil buffer.
%   Imop_Runtime_IsLoaded                                               - Check if Runtime main dll is loaded.
%   Imop_Runtime_IsLoaded_x64                                           - Check if Runtime main dll x64 is loaded.
%   Imop_Runtime_Load                                                   - Load Runtime main dll.
%   Imop_Runtime_Load_x64                                               - Load Runtime main dll x64.
%   Imop_Runtime_Unload                                                 - Unload Runtime main dll
%   Imop_Runtime_Unload_x64                                             - Unload Runtime main dll x64
%   Imop_Server_AddData                                                 - Configure server to support transfer of data named /p name with type /p type
%   Imop_Server_Delete                                                  - Server destructor.
%   Imop_Server_New                                                     - Server constructor from configuration file and port
%   Imop_Server_SetBool                                                 - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_SetImage                                                - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_SetInt                                                  - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_SetReal                                                 - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_SetSlopes                                               - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_SetString                                               - Set data corresponding to /p name. WARNING! Please make sur to choose the SetXXX method corresponding to your data type.
%   Imop_Server_Start                                                   - Start server
%   Imop_Short2LongPathName                                             - Not available
%   Imop_SlopesPostProcessorList_Delete                                 - SlopesPostProcessorList destructor
%   Imop_SlopesPostProcessorList_DeleteProcessor                        - Delete a single processor of the SlopesPostProcessorList
%   Imop_SlopesPostProcessorList_GetAdderParameters                     - Get parameters of the procAdder "Adder" processor.
%   Imop_SlopesPostProcessorList_GetDoublePathParameters                - Get parameters of the procDoublePath "DoublePath" processor.
%   Imop_SlopesPostProcessorList_GetFilterParameters                    - Get parameters of the procFilter "Filter" processor.
%   Imop_SlopesPostProcessorList_GetModulatorParameters                 - Get parameters of the procModulator "Modulator" processor.
%   Imop_SlopesPostProcessorList_GetPerfectLensParameters               - Get parameters of the procPerfectLens "PerfectLens" processor.
%   Imop_SlopesPostProcessorList_GetProcessorListNames                  - Get names of the the SlopesPostProcessors contained into the SlopesPostProcessorList.
%   Imop_SlopesPostProcessorList_GetProcessorListSize                   - Get the size of the SlopesPostProcessorList
%   Imop_SlopesPostProcessorList_GetPupilFromIntensityApplierParameters - Get parameters of the procPupilFromIntensityApplier "PupilFromIntensityApplier" processor.
%   Imop_SlopesPostProcessorList_GetPupilParameters                     - Get parameters of the procPupil "Pupil" processor.
%   Imop_SlopesPostProcessorList_GetScalerParameters                    - Get parameters of the procScaler "Scaler" processor.
%   Imop_SlopesPostProcessorList_GetShutOfBoundariesParameters          - Get parameters of the procShutOfBoundaries "ShutOfBoundaries" processor.
%   Imop_SlopesPostProcessorList_GetSubstractorParameters               - Get parameters of the procSubstractor "Substractor" processor.
%   Imop_SlopesPostProcessorList_InsertAdder                            - Insert a procAdder "Adder" processor.
%   Imop_SlopesPostProcessorList_InsertDoublePath                       - Insert a procDoublePath "DoublePath" processor.
%   Imop_SlopesPostProcessorList_InsertFilter                           - Insert a procFilter "Filter" processor.
%   Imop_SlopesPostProcessorList_InsertModulator                        - Insert a procModulator "Modulator" processor.
%   Imop_SlopesPostProcessorList_InsertNeighborExtension                - Insert a procNeighborExtension "NeighborExtension" processor.
%   Imop_SlopesPostProcessorList_InsertPerfectLens                      - Insert a procPerfectLens "PerfectLens" processor.
%   Imop_SlopesPostProcessorList_InsertPupil                            - Insert a procPupil "Pupil" processor.
%   Imop_SlopesPostProcessorList_InsertPupilFromIntensityApplier        - Insert a procPupilFromIntensityApplier "PupilFromIntensityApplier" processor.
%   Imop_SlopesPostProcessorList_InsertScaler                           - Insert a procScaler "Scaler" processor.
%   Imop_SlopesPostProcessorList_InsertShutOfBoundaries                 - Insert a procShutOfBoundaries "ShutOfBoundaries" processor.
%   Imop_SlopesPostProcessorList_InsertSlopesPostProcessorList          - Insert a SlopesPostProcessorList SubSlopesPostProcessorList in the SlopesPostProcessorList
%   Imop_SlopesPostProcessorList_InsertSubstractor                      - Insert a procSubstractor "Substractor" processor.
%   Imop_SlopesPostProcessorList_New                                    - SlopesPostProcessorList default constructor
%   Imop_SlopesPostProcessorList_NewFromCopy                            - SlopesPostProcessorList constructor from copy
%   Imop_SlopesPostProcessorList_NewFromHasFile                         - SlopesPostProcessorList constructor from a .has file
%   Imop_SlopesPostProcessor_ApplyAdder                                 - Adds Slopes_to_add to the input slopes.
%   Imop_SlopesPostProcessor_ApplyDoublePath                            - Divides the HasoSlopes by two.May ignore tilt and / or curvature depending on parametrization.
%   Imop_SlopesPostProcessor_ApplyFilter                                - Filters (remove) some HasoSlopes aberrations.
%   Imop_SlopesPostProcessor_ApplyModulator                             - Modulates (multiply by a real factor between 0 and 1) some HasoSlopes aberrations.
%   Imop_SlopesPostProcessor_ApplyNeighborExtension                     - Interpolates dark sub-pupils that are surrounded by light sub-pupils.
%   Imop_SlopesPostProcessor_ApplyPerfectLens                           - Adds the curvature of a perfect lens to the input slopes.
%   Imop_SlopesPostProcessor_ApplyPupil                                 - Replaces the slopes pupil by the intersection of the current one with the given one.
%   Imop_SlopesPostProcessor_ApplyPupilFromIntensity                    - Update Pupil according to Intensity thresholding result.
%   Imop_SlopesPostProcessor_ApplyScaler                                - Multiplies the input slopes by a float.
%   Imop_SlopesPostProcessor_ApplyShutOfBoundaries                      - Shuts off the sub-pupils close to boundaries (closing operation with a specified radius).
%   Imop_SlopesPostProcessor_ApplySubstractor                           - Subtracts Slopes_to_sutract to the input slopes.
%   Imop_Stitching_New                                                  - *stitching.
%   Imop_Surface_BoundingShapes                                         - Find the bounding square and bounding circle parameters centered on surface barycenter. Bouding square (resp. circle) is defined as the smallest square (resp. circle) such that SUM(values at (x,y) if (x,y) is in square(resp. circle)) > threshold. Surface must be normalized, i.e. sum(pixels of surface = 1 -> see Imop_Surface_Prepare method)
%   Imop_Surface_ComputeNoiseThreshold                                  - Compute noise threshold
%   Imop_Surface_Crop                                                   - Crop surface
%   Imop_Surface_Delete                                                 - Surface destructor.
%   Imop_Surface_EncircledEnergy                                        - Compute the sum of the values for pixels inside the specified circle. i.e. sum of the pixel values inside the circle. To be consistent with Imop_Surface_BoundingShapes, Surface must be normalized, i.e. sum(pixels of surface = 1 -> see Imop_Surface_BoundingShapes method)
%   Imop_Surface_EnsquaredEnergy                                        - Compute the sum of the values for pixels inside the specified square. i.e. sum of the pixel values inside the square. To be consistent with Imop_Surface_BoundingShapes, Surface must be normalized, i.e. sum(pixels of surface = 1 -> see Imop_Surface_BoundingShapes method)
%   Imop_Surface_GetData                                                - Get read access to Surface buffer.
%   Imop_Surface_GetDimensions                                          - Get Surface properties.
%   Imop_Surface_GetSpotArea                                            - Get spot area.
%   Imop_Surface_GetStatistics                                          - Get Surface statistics.
%   Imop_Surface_New                                                    - Surface constructor from dimensions and steps
%   Imop_Surface_NewFromCopy                                            - Surface constructor from dimensions and steps
%   Imop_Surface_Prepare                                                - Threshold surface values to remove noise and normalize such as sum(values) = 1
%   Imop_Surface_Projection                                             - Not available Surface projection on a half-line. Make a projection of a surface along a half-line. The half-line is defined by its origin (origin_x, origin_y) and the angle it forms with vector (1, 0). This origin is also used to locate the points of the half-line where values are given. Indeed, those points are identified by their distance from this origin. Function returns an array of distance and an array of the values of the surface at the corresponding points. Returned distances take surface's steps into account while input angle does not. Surface      Surface object adress.
%   Imop_Surface_Resize                                                 - Not available Surface resize. Surface        Surface object adress.
%   Imop_Surface_SetData                                                - Get write access to Surface buffer.
%   Imop_Surface_TransposeAndFlip                                       - Operate an optionnal transposition on Surface (swap x and y) followed by optionnal flip x then flip y transformations.
%   Imop_Surface_Zoom                                                   - Not available Surface zoom. Surface        Surface object adress.
%   Imop_WavefrontCorrectorSet_Delete                                   - WavefrontCorrectorSet destructor
%   Imop_WavefrontCorrectorSet_GetActuatorsCount                        - WavefrontCorrector actuators count getter.
%   Imop_WavefrontCorrectorSet_GetAvailableValue                        - If parameter is a string to be selected among a finite set of strings, extract the possible value located at the /p index position from this set. See Imop_WavefrontCorrectorSet_GetParameterOption.
%   Imop_WavefrontCorrectorSet_GetAvailableValuesListSize               - If parameter is a string to be selected among a finite set of strings, return the size of this set. See Imop_WavefrontCorrectorSet_GetParameterOption.
%   Imop_WavefrontCorrectorSet_GetFlatMirrorPositions                   - WavefrontCorrector commands to flat mirror shape getter.
%   Imop_WavefrontCorrectorSet_GetInitialPreferences                    - WavefrontCorrector constraints getter.
%   Imop_WavefrontCorrectorSet_GetParameterBooleanDefaultValue          - WavefrontCorrector parameter default value getter for parameter of type boolean.
%   Imop_WavefrontCorrectorSet_GetParameterIntDefaultValue              - WavefrontCorrector parameter default value getter for parameter of type integer.
%   Imop_WavefrontCorrectorSet_GetParameterIntLimits                    - WavefrontCorrectorSet parameter range getter for parameter of type integer.
%   Imop_WavefrontCorrectorSet_GetParameterListSize                     - WavefrontCorrector parameters list size getter.
%   Imop_WavefrontCorrectorSet_GetParameterName                         - WavefrontCorrector parameter name getter given its position in the parameters list.
%   Imop_WavefrontCorrectorSet_GetParameterOption                       - WavefrontCorrector parameter options getter given its name which should have been read with Imop_WavefrontCorrectorSet_GetParameterName.
%   Imop_WavefrontCorrectorSet_GetParameterRealDefaultValue             - WavefrontCorrector parameter default value getter for parameter of type float.
%   Imop_WavefrontCorrectorSet_GetParameterRealLimits                   - WavefrontCorrectorSet parameter range getter for parameter of type float.
%   Imop_WavefrontCorrectorSet_GetParameterStringDefaultValue           - WavefrontCorrector parameter default value getter for parameter of type string.
%   Imop_WavefrontCorrectorSet_GetParameterType                         - WavefrontCorrector parameter type getter given its name which should have been read with Imop_WavefrontCorrectorSet_GetParameterName.
%   Imop_WavefrontCorrectorSet_GetSpecifications                        - WavefrontCorrector specifications getters
%   Imop_WavefrontCorrectorSet_GetSpecificFeatureName                   - WavefrontCorrector features name getter given its position in the parameters list.
%   Imop_WavefrontCorrectorSet_GetSpecificFeaturesListSize              - WavefrontCorrector features list size getter.
%   Imop_WavefrontCorrectorSet_NewFromConfigFile                        - WavefrontCorrectorSet constructor
%   Imop_WavefrontCorrectorSet_SaveSpecificationsAndPositionsToFile     - Not available Create pmc file with current wavefront corrector specifications and forced positions. wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%   Imop_WavefrontCorrector_AssertEqualPreferences                      - Assert requested preferences are equal to current preferences
%   Imop_WavefrontCorrector_CallSpecificFeature                         - Perform a wavefront corrector action regarding its name.
%   Imop_WavefrontCorrector_CheckAbsolutePositions                      - Assert if requested absolute positions satisfy current preferences. If actuator condition is E_ACTUATOR_CONDITION_INVALID, no error is thrown, since position will be ignored by the Wavefront corrector.
%   Imop_WavefrontCorrector_CheckActuatorAbsolutePosition               - Assert if requested absolute position satisfy current preferences. If actuator is invalid, no error is thrown, since position will be ignored by the Wavefront corrector.
%   Imop_WavefrontCorrector_CheckActuatorRelativePosition               - Assert if requested relative position satisfy current preferences. If actuator is invalid, no error is thrown, since position will be ignored by the Wavefront corrector.
%   Imop_WavefrontCorrector_CheckActuatorUserPreferences                - Assert requested preferences fulfill specifications constraints
%   Imop_WavefrontCorrector_CheckRelativePositions                      - Assert if requested relative positions satisfy current preferences. If actuator condition is E_ACTUATOR_CONDITION_INVALID, no error is thrown, since position will be ignored by the Wavefront corrector.
%   Imop_WavefrontCorrector_CheckUserPreferences                        - Assert requested preferences fulfill specifications constraints
%   Imop_WavefrontCorrector_ComputeDeltaCommandAmplitude                - Compute a relative move amplitude as the max displacement percentage among all the valid actuators. For one actuator : Displacement percentage = displacement / (max - min) * 100
%   Imop_WavefrontCorrector_Delete                                      - WavefrontCorrector destructor
%   Imop_WavefrontCorrector_GetActuatorCurrentPosition                  - Get current position of actuator
%   Imop_WavefrontCorrector_GetActuatorPreferences                      - Get preferences of actuator
%   Imop_WavefrontCorrector_GetCurrentPositions                         - Get current actuators positions
%   Imop_WavefrontCorrector_GetParameterBoolean                         - Wavefront corrector parameter getter for parameter of type E_TYPE_BOOL.
%   Imop_WavefrontCorrector_GetParameterInt                             - Wavefront corrector parameter getter for parameter of type E_TYPE_INT.
%   Imop_WavefrontCorrector_GetParameterReal                            - Wavefront corrector parameter getter for parameter of type E_TYPE_REAL.
%   Imop_WavefrontCorrector_GetParameterString                          - Wavefront corrector parameter getter for parameter of type E_TYPE_STRING.
%   Imop_WavefrontCorrector_GetPositionsFromFile                        - Get Wavefront corrector positions from positions file.
%   Imop_WavefrontCorrector_GetPreferences                              - Get current preferences
%   Imop_WavefrontCorrector_GetTemporization                            - Get current WavefrontCorrector preference "Time to stabilization (ms)".
%   Imop_WavefrontCorrector_Init                                        - Initialize wavefront corrector positions
%   Imop_WavefrontCorrector_MoveActuatorToAbsolutePosition              - Move to requested absolute position, clip according to current preferences.
%   Imop_WavefrontCorrector_MoveActuatorToRelativePosition              - Move to requested relative position, clip according to current preferences.
%   Imop_WavefrontCorrector_MoveToAbsolutePositions                     - Move to requested absolute positions, clip according to current preferences.
%   Imop_WavefrontCorrector_MoveToRelativePositions                     - Move to requested relative positions, clip according to current preferences.
%   Imop_WavefrontCorrector_NewFromConfigFile                           - WavefrontCorrector constructor
%   Imop_WavefrontCorrector_SaveCurrentPositionsToFile                  - Save current Wavefront corrector positions to positions file.
%   Imop_WavefrontCorrector_SetActuatorPreferences                      - Set preferences of actuator
%   Imop_WavefrontCorrector_SetParameterBoolean                         - WavefrontCorrector parameter setter for parameter of type E_TYPE_BOOL.
%   Imop_WavefrontCorrector_SetParameterInt                             - WavefrontCorrector parameter setter for parameter of type E_TYPE_INT.
%   Imop_WavefrontCorrector_SetParameterReal                            - WavefrontCorrector parameter setter for parameter of type E_TYPE_REAL.
%   Imop_WavefrontCorrector_SetParameterString                          - WavefrontCorrector parameter setter for parameter of type E_TYPE_STRING.
%   Imop_WavefrontCorrector_SetPreferences                              - Apply requested preferences, clip or ignore if specifications constraints are not fulfilled
%   Imop_WavefrontCorrector_SetTemporization                            - Set current WavefrontCorrector preference "Time to stabilization (ms)", clip or ignore if specifications constraints are not fulfilled.
