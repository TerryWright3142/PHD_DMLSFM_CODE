function [err_message, driver_name, wavefrontcorrector_name, wavefrontcorrector_serial_number, revision, actuators_count, min_sleep_after_movement, has_internal_memory] = Imop_WavefrontCorrectorSet_GetSpecifications(wavefrontcorrector_set)

% IMOP_WAVEFRONTCORRECTORSET_GETSPECIFICATIONS WavefrontCorrector specifications getters
% 
%    wavefrontcorrector_set            WavefrontCorrectorSet object adress.
%                                      
%    err_message                       Error message, empty if no error occured.
%                                      
%    driver_name                       Wavefront corrector driver name.
%                                      
%    wavefrontcorrector_name           Wavefront corrector pretty name.
%                                      
%    wavefrontcorrector_serial_number  Wavefront corrector serial number.
%                                      
%    revision                          Wavefront corrector revision.
%                                      
%    actuators_count                   Wavefront corrector actuators count.
%                                      
%    min_sleep_after_movement          Wavefront corrector actuators stabilization delay.
%                                      
%    has_internal_memory               True if Wavefront corrector electronic can store its position, else false.
%                                      
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrectorSet_GetSpecifications" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
driver_name = char(ones(256,1,'int8'));
wavefrontcorrector_name = char(ones(256,1,'int8'));
wavefrontcorrector_serial_number = char(ones(256,1,'int8'));
revision = 0;
actuators_count = 0;
min_sleep_after_movement = 0;
has_internal_memory = 0;

[err_nb, err_message, driver_name, wavefrontcorrector_name, wavefrontcorrector_serial_number, revision, actuators_count, min_sleep_after_movement, has_internal_memory] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_GetSpecifications', err_message, wavefrontcorrector_set, driver_name, wavefrontcorrector_name, wavefrontcorrector_serial_number, revision, actuators_count, min_sleep_after_movement, has_internal_memory);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
