function [err_message, stitching] = Imop_Stitching_New(params_file_path)

% IMOP_STITCHING_NEW *stitching.
% 
%    params_file_path  Absolute path to stitching parameters file.
%                      
%    err_message       Error message, empty if no error occured.
%                      
%    stitching         Pointer to stitching object.
%                      
% 

if nargin ~= 1
	error('The "Imop_Stitching_New" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
stitching = 0;

[err_nb, err_message, stitching, params_file_path] = calllib('WaveKitRuntime', 'Imop_Stitching_New', err_message, stitching, params_file_path);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
