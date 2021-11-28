function [err_message, nb_black_regions, nb_white_regions, nb_regions] = Imop_Pupil_RegionsStats(Pupil)

% IMOP_PUPIL_REGIONSSTATS Get statistics on pupil regions
% 
%    Pupil             Pupil object adress.
%                      
%    err_message       Error message, empty if no error occured
%                      
%    nb_black_regions  Number of regions where subpupils are off.
%                      
%    nb_white_regions  Number of regions where subpupils are enlighted.
%                      
%    nb_regions        Total number of regions.
%                      
% 

if nargin ~= 1
	error('The "Imop_Pupil_RegionsStats" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
nb_black_regions = 0;
nb_white_regions = 0;
nb_regions = 0;

[err_nb, err_message, nb_black_regions, nb_white_regions, nb_regions] = calllib('WaveKitRuntime', 'Imop_Pupil_RegionsStats', err_message, Pupil, nb_black_regions, nb_white_regions, nb_regions);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
