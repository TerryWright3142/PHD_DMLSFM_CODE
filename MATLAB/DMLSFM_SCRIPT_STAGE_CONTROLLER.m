% Stage Controller
% constantly monitors config.xml and if the stage position is changed
% by another program then the stage will move to that position.

disp('Starting slave controller');

addpath('.\NEWPORT_ESP_100');
disp('INIT STAGE');
stage = Newport_ESP100();
comPort = 12; % change the COM port as needed
stage.Init(comPort);
fprintf('STAGE at start position %d \n', stage.GetPositionAbs() );
stage.SetMaxVelocity(0.02);
stage.AbsMoveSynch(5);
fprintf('STAGE at mid position %d \n', stage.GetPositionAbs() );
disp('Homing finished');
input('Enter any number when ready to continue ');

while true
    
    xmlSz = fileread([szFolder 'stage_config.xml']);
    szList = ["stagePosition"];
    szList1 = zeros(size(szList));
    for f = 1:numel(szList)
        cac = regexp(xmlSz, ['<' char(szList(f)) '>([+-]?\d+\.?\d*)'], 'tokens');
        szList1(f) = str2num(char(cac{1}));
    end
    stagePosition = szList1(1);
    if curStagePos ~= stagePosition
        %move the stage
                stage.AbsMoveSynch((stagePosition )/1000 + 5 - 0.1);
                stage.AbsMoveSynch((stagePosition )/1000 + 5 ); 
                curStagePos = stagePosition;
                fprintf('STAGE MOVED TO %d \n', curStagePos);
                  
    end
    pause(2);
    
end


%%
stage.Shutdown();
