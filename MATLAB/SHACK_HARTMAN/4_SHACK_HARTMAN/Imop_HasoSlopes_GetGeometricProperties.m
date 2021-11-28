function [err_message, tiltX_mrad, tiltY_mrad, radius_mm, focus_Xpos_mm, focus_Ypos_mm, astig_angle_rad, sagittal_focal_length_mm, tangential_focal_length_mm] = Imop_HasoSlopes_GetGeometricProperties(HasoSlopes)

% IMOP_HASOSLOPES_GETGEOMETRICPROPERTIES Compute HasoSlopes geometric properties.
% 
%    HasoSlopes                  HasoSlopes object adress.
%                                
%    err_message                 Error message, empty if no error occured.
%                                
%    tiltX_mrad                  x tilt (mrad).
%                                
%    tiltY_mrad                  y tilt (mrad).
%                                
%    radius_mm                   radius (mm).
%                                
%    focus_Xpos_mm               x focus position (mm).
%                                
%    focus_Ypos_mm               y focus position (mm).
%                                
%    astig_angle_rad             astgimatism angle (rad).
%                                
%    sagittal_focal_length_mm    sagittal focal length (mm).
%                                
%    tangential_focal_length_mm  tangential focal length (mm).
%                                
% 

if nargin ~= 1
	error('The "Imop_HasoSlopes_GetGeometricProperties" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
tiltX_mrad = 0;
tiltY_mrad = 0;
radius_mm = 0;
focus_Xpos_mm = 0;
focus_Ypos_mm = 0;
astig_angle_rad = 0;
sagittal_focal_length_mm = 0;
tangential_focal_length_mm = 0;

[err_nb, err_message, tiltX_mrad, tiltY_mrad, radius_mm, focus_Xpos_mm, focus_Ypos_mm, astig_angle_rad, sagittal_focal_length_mm, tangential_focal_length_mm] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_GetGeometricProperties', err_message, HasoSlopes, tiltX_mrad, tiltY_mrad, radius_mm, focus_Xpos_mm, focus_Ypos_mm, astig_angle_rad, sagittal_focal_length_mm, tangential_focal_length_mm);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
