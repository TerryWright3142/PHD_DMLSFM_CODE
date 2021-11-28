function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromHasoData(HasoData, apply_processing)

% IMOP_HASOSLOPES_NEWFROMHASODATA HasoSlopes constructor from Haso configuration file
% 
%    HasoData          Pointer to HasoData object.
%                      
%    apply_processing  If true, created HasoSlopes will contain the processed slopes of the HasoData, else HasoSlopes will contain the raw slopes of the HasoData.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    HasoSlopes        Pointer to HasoSlopes object adress.
%                      
% 

if nargin ~= 2
	error('The "Imop_HasoSlopes_NewFromHasoData" function requires 2 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromHasoData', err_message, HasoSlopes, HasoData, apply_processing);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
