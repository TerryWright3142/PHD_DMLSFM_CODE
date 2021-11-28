function [err_message, nb_actuators, wavefrontcorrector_name, wavefrontcorrector_serial_number, haso_slopes_size, haso_slopes_step, haso_serial_number] = Imop_CorrDataManager_GetSpecifications(corrdata_manager)

% IMOP_CORRDATAMANAGER_GETSPECIFICATIONS Haso and Wavefront corrector specifications getter.
% 
%    corrdata_manager                  CorrDataManager object adress.
%                                      
%    err_message                       Error message, empty if no error occured.
%                                      
%    nb_actuators                      Wavefront corrector actuators count.
%                                      
%    wavefrontcorrector_name           Wavefront corrector pretty name.
%                                      
%    wavefrontcorrector_serial_number  Wavefront corrector serial number.
%                                      
%    haso_slopes_size                  Haso measures (HasoSlopes) dimensions.
%                                      
%    haso_slopes_step                  Haso measures (HasoSlopes) sampling step (um).
%                                      
%    haso_serial_number                Haso serial number.
%                                      
% 

if nargin ~= 1
	error('The "Imop_CorrDataManager_GetSpecifications" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_actuators = 0;
wavefrontcorrector_name = char(ones(256,1,'int8'));
wavefrontcorrector_serial_number = char(ones(256,1,'int8'));
haso_slopes_size = [];
haso_slopes_step = [];
haso_serial_number = char(ones(256,1,'int8'));

[err_nb, err_message, nb_actuators, wavefrontcorrector_name, wavefrontcorrector_serial_number, haso_slopes_size, haso_slopes_step, haso_serial_number] = calllib('WaveKitRuntime', 'Imop_CorrDataManager_GetSpecifications', err_message, corrdata_manager, nb_actuators, wavefrontcorrector_name, wavefrontcorrector_serial_number, haso_slopes_size, haso_slopes_step, haso_serial_number);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
