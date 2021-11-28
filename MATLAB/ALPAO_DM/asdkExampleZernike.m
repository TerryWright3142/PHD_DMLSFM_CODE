% Add 'Wrapper' folder to Matlab path
addpath( [pwd '/Wrapper/'] );

% Alpao SDK example apply Zernike using one mirror
%
%  This script initialize the connection with the DM,
% sends Zernike one by one for 1 seconds, reset the deformable mirror
% and release the connection.

%% Set your mirror serial name
mirrorSN = 'BXLXXX';

%% Initialise new mirror object
dm = asdkDM( mirrorSN );

%% Load matrix Zernike to command matrix
% in NOLL's order without Piston in µm RMS
Z2C = importdata( [mirrorSN '-Z2C.mat'] );

% Number of Zernile in Z2C (Zernike to mirror Command matrix)
nZern = size(Z2C, 1);

% Check the number of actuator
if dm.nAct ~= size(Z2C, 2)
   error( 'ASDK:NAct', 'Number of actuator mismatch.' );
end

% For example:
%  Z2C(1,:) is the mirror command vector for Tip
%  Z2C(2,:) is the mirror command vector for Tilt
%  Z2C(3,:) is the mirror command vector for Defocus
%  ...

%% Apply first Zernike one by one on mirror (use only 15 modes)
zernikeVector = zeros( 1, nZern );

fprintf( 'Send Zernike to the mirror: #XX' );
for zern = 1:min(nZern,15)
   zernikeVector( zern ) = 0.1;    % Apply 0.1 µm RMS on Zernike #zern
   
   fprintf( '\b\b%02d', zern );    % Print Zernike index
   
   dm.Send( zernikeVector * Z2C ); % Send command to mirror
   
   zernikeVector( zern ) = 0;      % Reset Zernike vector
   pause( 1 );
end
fprintf( '\b\b\bDone\n' );

%% Reset the mirror (send zeros) 
dm.Reset();

% Clear object
clear dm;