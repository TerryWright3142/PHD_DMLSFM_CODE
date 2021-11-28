% Add 'Wrapper' folder to Matlab path
addpath( [pwd '/Wrapper/'] );
mm = load('InfFunctions_HSDM97-15-014.mat');
dm = asdkDM('HSDM97-15-014' );

nbAct = dm.Get( 'NbOfActuator' );
mInf = mm.InfFunctionResults.influenceMatrix;
pupil = ones(size(mm.wfMask));
wPupil = ~isnan(mm.wfMask);



z = 0;
 z = input('actuator: ');
   val = input('value: ');
          data = zeros( nbAct, 1 )';
while z<100

    if z~=0

        data(z) = val;
    else
           data = zeros( nbAct, 1 )';
    end

   dm.Send( data );
  z = input('actuator: ');
  val = input('value: ');
end


dm.Reset( );

% Clear object
clear dm;
clear nbAct data;