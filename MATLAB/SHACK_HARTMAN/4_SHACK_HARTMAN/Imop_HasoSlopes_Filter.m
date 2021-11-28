function [err_message, ax, bx, cx, ay, by, cy] = Imop_HasoSlopes_Filter(HasoSlopes, HasoSlopes_processed, tiltx, tilty, curv, astig0, astig45)

% IMOP_HASOSLOPES_FILTER Not available
%    WARNING! Slopes filtering is not based on polynomial decomposition (Zernike or Legendre).
%    Computed Phase based on filtered slopes then can differ from computed then filtered Phase depending on the chosen phase reconstruction algorithm.
%    Please consider using Slopes filtering for AO target creation and Phase filtering for display.
% Filter the HasoSlopes input. Remove :
%    - Z1 = ax*m_X + bx*m_Y + cx from x slopes,
%    - Z2 = ay*m_X + by*m_Y + cy from y slopes.
%    HasoSlopes            HasoSlopes object adress.
%                          
%    HasoSlopes_processed  filtered HasoSlopes object adress.
%                          
%    tiltx                 x tilt filter.
%                          
%    tilty                 y tilt filter.
%                          
%    curv                  curvature filter.
%                          
%    astig0                0 degree astigmatism filter.
%                          
%    astig45               45 degree astigmatism filter.
%                          
%    err_message           Error message, empty if no error occured.
%                          
%    ax                    ax coeffcient of the Z1 plan.
%                          
%    bx                    bx coeffcient of the Z1 plan.
%                          
%    cx                    cx coeffcient of the Z1 plan.
%                          
%    ay                    ay coeffcient of the Z2 plan.
%                          
%    by                    by coeffcient of the Z2 plan.
%                          
%    cy                    cy coeffcient of the Z2 plan.
%                          
% 

if nargin ~= 7
	error('The "Imop_HasoSlopes_Filter" function requires 7 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
ax = 0;
bx = 0;
cx = 0;
ay = 0;
by = 0;
cy = 0;

[err_nb, err_message, ax, bx, cx, ay, by, cy] = calllib('WaveKitRuntime', 'Imop_HasoSlopes_Filter', err_message, HasoSlopes, HasoSlopes_processed, tiltx, tilty, curv, astig0, astig45, ax, bx, cx, ay, by, cy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
