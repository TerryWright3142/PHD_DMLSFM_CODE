function err_message = Imop_Intensity_Delete(Intensity)

% IMOP_INTENSITY_DELETE Intensity destructor
% 
%    Intensity    Intensity object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
% 

if nargin ~= 1
	error('The "Imop_Intensity_Delete" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));

[err_nb, err_message] = calllib('WaveKitRuntime', 'Imop_Intensity_Delete', err_message, Intensity);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
