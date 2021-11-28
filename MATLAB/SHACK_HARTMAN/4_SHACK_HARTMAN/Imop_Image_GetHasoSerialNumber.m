function [err_message, haso_serial_number] = Imop_Image_GetHasoSerialNumber(Image)

% IMOP_IMAGE_GETHASOSERIALNUMBER Get Haso serial number from Image object if Image has been captured with a Haso sensor, else return an error.
% 
%    Image               Image object adress.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    haso_serial_number  Haso serial number.
%                        
% 

if nargin ~= 1
	error('The "Imop_Image_GetHasoSerialNumber" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
haso_serial_number = char(ones(256,1,'int8'));

[err_nb, err_message, haso_serial_number] = calllib('WaveKitRuntime', 'Imop_Image_GetHasoSerialNumber', err_message, Image, haso_serial_number);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
