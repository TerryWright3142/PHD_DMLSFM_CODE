function err_message = Imop_WavefrontCorrector_Init(corrector, set_init_state_from_config_file)

% IMOP_WAVEFRONTCORRECTOR_INIT Initialize wavefront corrector positions
% 
%    corrector                        WavefrontCorrector object adress.
%                                     
%    set_init_state_from_config_file  if true, using initial positions from configuration file.
%                                     
%    err_message                      Error message, empty if no error occured.
%                                     
% 

if nargin ~= 2
	error('The "Imop_WavefrontCorrector_Init" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrector_Init', err_message, corrector, set_init_state_from_config_file);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
