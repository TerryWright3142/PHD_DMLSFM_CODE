function err_message = Imop_CorrDataManager_ComputeInteractionMatrix(CorrDataManager, HasoSlopes_array_size, HasoSlopes_array)

% IMOP_CORRDATAMANAGER_COMPUTEINTERACTIONMATRIX Compute interaction matrix from collected calibration data (two HasoSlopes measured per actuator).
%    WARNING! Calibration HasoSlopes associated to an invalid actuator must be valid HasoSlopes objects anyway and not NULL pointers.
% 
%    CorrDataManager        CorrDataManager object adress.
%                           
%    HasoSlopes_array_size  Measured HasoSlopes array size (must be 2 x actuators number)
%                           
%    HasoSlopes_array       HasoSlopes measured for each calibration step.
%                           
%    err_message            Error message, empty if no error occured.
%                           
% 

if nargin ~= 3
	error('The "Imop_CorrDataManager_ComputeInteractionMatrix" function requires 3 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message, HasoSlopes_array] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_ComputeInteractionMatrix', err_message, CorrDataManager, HasoSlopes_array_size, HasoSlopes_array);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
