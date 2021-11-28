function err_message = Imop_CorrDataManager_SetMicrolensesFocalLength(corrdata_manager, microlenses_focal_length_um)

% IMOP_CORRDATAMANAGER_SETMICROLENSESFOCALLENGTH Micro lenses focal length setter.Provided for backward compatibility with old formatted interaction matrix backup files.
%    This value is used for correction loop computations.
%    If a focal length value has already been set in the correction data manager, it won't be replaced.
% 
%    corrdata_manager             CorrDataManager object adress.
%                                 
%    microlenses_focal_length_um  Micro lenses focal length (um).
%                                 
%    err_message                  Error message, empty if no error occured.
%                                 
% 

if nargin ~= 2
	error('The "Imop_CorrDataManager_SetMicrolensesFocalLength" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_SetMicrolensesFocalLength', err_message, corrdata_manager, microlenses_focal_length_um);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
