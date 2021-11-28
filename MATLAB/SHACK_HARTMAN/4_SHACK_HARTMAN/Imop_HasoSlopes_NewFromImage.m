function [err_message, HasoSlopes] = Imop_HasoSlopes_NewFromImage(Image, config_file_path, start_subpupil)

% IMOP_HASOSLOPES_NEWFROMIMAGE HasoSlopes constructor from HasoSlopes.
% This constructor computes the slopes on the input Image object
%    and creates the corresponding HasoSlopes object.
%    The slopes computation core (HasoEngine) parameters are all set to their default values
%    and cannot be modified, excepting the start sub-pupil coordinates.
%    If no start sub-pupil coordinates are provided, default values from configuration file are used.
%    Image             Image object adress.
%                      
%    config_file_path  Absolute path to Haso configuration file.
%                      
%    start_subpupil    Coordinates of the first calculated sub-pupil (index coordinates relative to the top-left corner of the pupil).
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    HasoSlopes        Pointer to HasoSlopes object adress.
%                      
% 

if nargin < 2
	error('The "Imop_HasoSlopes_NewFromImage" function requires at least 2 input argument(s).');
elseif nargin > 3
	error('The "Imop_HasoSlopes_NewFromImage" function cannot have more than 3 input argument(s).');
end
if nargin<=2
	start_subpupil=0;
end
err_message = char(ones(256,1,'int8'));
HasoSlopes = 0;

[err_nb, err_message, HasoSlopes, config_file_path, start_subpupil] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_NewFromImage', err_message, HasoSlopes, Image, config_file_path, start_subpupil);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
