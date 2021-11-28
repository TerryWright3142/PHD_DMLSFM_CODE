% Add 'Wrapper' folder to Matlab path
addpath( [pwd '/Wrapper/'] );
dm = asdkDM('HSDM97-15-014' );
% Get the number of actuators
nbAct = dm.Get( 'NbOfActuator' );
fprintf( 'Number of actuators: %d.\n', nbAct );

%% Initialize data
data = zeros( nbAct, 1 );

% Send it
disp( 'Send data to the mirror:' );
for k = 1:nbAct
    data = zeros( nbAct, 1 );
    % Set actuator #k to 10%
    data( k ) = 1;
    
    % Send value to the DM
    dm.Send( data );
    fprintf( '.' );
    
    % Wait to see data on mirror
    pause( 0.2 );
    
    % Reset actuator #k to 0 for next step
    data( k ) = 0;
end
disp( 'Done.' );

%% Send zeros to the DM
dm.Reset( );

% Clear object
clear dm;
clear nbAct data;