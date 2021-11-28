function [err_message, HasoSlopes, trimmer_quality] = Imop_HasoEngine_ComputeSlopes(HasoEngine, HasoSlopes, image, learn_from_trimmer)

% IMOP_HASOENGINE_COMPUTESLOPES Compute HasoSlopes.
%    Please check that parameters have been set, and alignment step is completed.
% 
%    HasoEngine          HasoEngine object adress.
%                        
%    image               Input image object.
%                        
%    learn_from_trimmer  If True, a possible mis-alignement is corrected by correlating the observed high-frequency aberrations.
%                        with a pre-calibrated map (trimmer).
%                        \warning The results may be distorted if the analyzed wavefront presents high-frequency aberrations
%                        or if the illuminated surface area on the sensor is too small (< 30%).
%                        
%    HasoSlopes          Computed HasoSlopes.
%                        
%    err_message         Error message, empty if no error occured.
%                        
%    trimmer_quality     If align_from_trimmer is true, correlation factor between the observed high-frequency aberrations and the pre-calibrated map.
%                        
% 

if nargin ~= 4
	error('The "Imop_HasoEngine_ComputeSlopes" function requires 4 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
trimmer_quality = 0;

[err_nb, err_message, trimmer_quality] = calllib('WaveKitRuntime', 'Imop_HasoEngine_ComputeSlopes', err_message, HasoEngine, HasoSlopes, image, learn_from_trimmer, trimmer_quality);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
