function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromModalCoef(ModalCoef, config_file_path)

% IMOP_HASOSLOPES_NEWFROMMODALCOEF HasoSlopes constructor from HasoSlopes.
% This constructor computes the slopes on the input ModalCoef
%    using the type of reconstruction and projection pupil defined in it (Legendre or Zernike)
%    and creates the corresponding HasoSlopes object.
%    Modal coeffs must have a projection pupil set in their preferences.
%    ModalCoef         ModalCoef object adress.
%                      
%    config_file_path  Absolute path to Haso configuration file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    HasoSlopes        Pointer to HasoSlopes object adress.
%                      
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_NewFromModalCoef" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes, config_file_path] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromModalCoef', err_message, HasoSlopes, ModalCoef, config_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
