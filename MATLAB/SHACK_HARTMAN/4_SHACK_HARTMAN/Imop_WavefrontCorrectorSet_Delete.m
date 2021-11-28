function err_message = Imop_WavefrontCorrectorSet_Delete(wavefrontcorrector_set)

% IMOP_WAVEFRONTCORRECTORSET_DELETE WavefrontCorrectorSet destructor
% 
%    wavefrontcorrector_set  WavefrontCorrectorSet object adress.
%                            
%    err_message             Error message, empty if no error occured.
%                            
% 

if nargin ~= 1
	error('The "Imop_WavefrontCorrectorSet_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_WavefrontCorrectorSet_Delete', err_message, wavefrontcorrector_set);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
