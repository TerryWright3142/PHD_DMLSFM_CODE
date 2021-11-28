% OK as of 2/12
classdef Newport_ESP100 < Stage
    properties
       serialPort
       limitMax
       limitMin
       currentPos
       maxVelocity
       maxAcceleration
       recordFile
         
    end
    methods 
        % why is the home position outside of the hardware limits
        % needs better commenting
        % the functions need better names
        function obj = Newport_ESP100() 
            obj.recordFile = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\NEWPORT_ESP_100\record.txt';
        end
        function Init(obj, COMport)
            
            %%check this
            obj.serialPort = instrfind;
            if isempty(obj.serialPort)==0
                fclose(obj.serialPort);
                delete(obj.serialPort)
            end

            disp('Activate COM port');
            obj.serialPort=serial(strcat('COM', string(COMport)), ...
                'BaudRate',19200,'DataBits', ...
                8,'FlowControl','software','Terminator','CR/LF');
            set(obj.serialPort, 'Tag', 'ESP100');
            set(obj.serialPort, 'TimeOut', .1);  
            set(obj.serialPort, 'OutputBufferSize', 300 );
            set(obj.serialPort, 'InputBufferSize',  300 );
%%can we record the COM port?
            
            disp('Open COM port');
            fopen(obj.serialPort); 
            pause(1);
            %tutorial gave it a sec to start getting data
            
            obj.serialPort.RecordDetail = 'verbose';
            obj.serialPort.RecordName = obj.recordFile;
            record(obj.serialPort,'on')

            obj.SetFollowingErrorConfig(0);
 
            obj.MotorOn();
            obj.Home(); 
            obj.DefineHome();
            
            % software limits for the TRA12CC actuator
            %obj.SetSoftwareLimitConfig(7);
            %stage.SetSoftwareLimitLeft(-5);
            %stage.SetSoftwareLimitRight(5);
        end
        function Shutdown(obj)

            disp('turn off motor');
            fprintf(obj.serialPort,'1MF');  % turn off the motor
            disp('shut down COM');
            record(obj.serialPort,'off')
            fclose(obj.serialPort);
            delete(obj.serialPort);
            
        end
        function SetSoftwareLimits(obj, left, right)
           
            obj.SetSoftwareLimitLeft(left);
            obj.SetSoftwareLimitRight(right); 
            obj.SetSoftwareLimitConfig(7);
            
        end
        function Home(obj)
            obj.WriteCmd('1OR2');
            obj.BlockWhileMoving();
        end 
        function FindHWRanges(obj)
            obj.MoveToHardwareLimitMin();
            disp(['min limit=' string(obj.GetPositionAbs())]); 
            obj.MoveToHardwareLimitMax();
            disp(['max limit=' string(obj.GetPositionAbs())]);           
        end
        function AbsMoveSynch(obj, pos)
            obj.AbsMoveAsynch(pos);
            obj.BlockWhileMoving();
        end
        function Move(obj, bPos)
            if bPos
               obj.WriteCmd('1MV+'); 
                
            else
               obj.WriteCmd('1MV-');            
                
            end
            
        end
        function RelMoveSynch(obj, rel_pos)
            obj.RelMoveAsynch(rel_pos);
            obj.BlockWhileMoving();
        end
        function AbsMoveAsynch(obj, pos)
            obj.WriteCmd(['1PA' char(string(pos)) ]);
        end
        function RelMoveAsynch(obj, rel_pos)
            obj.WriteCmd(['1PR' char(string(rel_pos)) ]);
            end
        function ReadError(obj)
           disp(obj.ReadCmd('tb'));
        end
        function MotorOn(obj)
            obj.WriteCmd('1MO');
        end
        function MotorOff(obj)
            obj.WriteCmd('1MF');
        end
        function StopMotion(obj)
            obj.WriteCmd('1ST');       
        end
        function pos = GetPositionAbs(obj)
           pos = str2double(obj.ReadCmd('1pa?'));
        end
        function rng = GetLimits(obj)
            sr = obj.GetSoftwareLimitRight();
            sl = obj.GetSoftwareLimitLeft();
            rng = [sl, sr];
        end 
        function lt = GetSoftwareLimitLeft(obj)
            lt = str2double(obj.ReadCmd('1sl?'));
        end
        function lt = GetSoftwareLimitRight(obj)
            lt = str2double(obj.ReadCmd('1sr?'));       
        end
        function SetSoftwareLimitLeft(obj, left)
           % disp('this is the negative direction');
            obj.WriteCmd(['1sl' char(string(left))]);
        end
        function SetSoftwareLimitRight(obj, right)
           % disp('this is the positive direction');
            obj.WriteCmd(['1sr' char(string(right))]);       
            
        end
        function units = GetUnits(obj)
            units = obj.ReadCmd('1sn?');%2 IS mm, 3 is um
        end
        function MoveToHardwareLimitMax(obj)
            obj.WriteCmd('1MT+');
            obj.BlockWhileMoving();
        end
        function MoveToHardwareLimitMin(obj)
            obj.WriteCmd('1MT-');  
            obj.BlockWhileMoving();
        end
        function vel = GetMaxVelocity(obj)
            vel = str2double(obj.ReadCmd('1va?'));
          
        end
        function acc = GetMaxAcceleration(obj)
             acc = str2double(obj.ReadCmd('1ac?')); 
        end
        function SaveToNonVolatileMem(obj)
             obj.WriteCmd('sm');                       
        end
        function SetMaxVelocity(obj, vel)
            obj.WriteCmd(['1va' char(string(vel))]);             
        end
        function SetMaxAcceleration(obj, acc)
            obj.WriteCmd(['1va' char(string(acc))]);                      
        end
        function res = GetFollowingErrorConfig(obj)
            res = obj.ReadCmd('1ZF?');
            % 3H is 
            
        end
        function SetFollowingErrorConfig(obj, val)
            obj.WriteCmd(['1ZF' char(string(val))]); 
            %set to 0 to ignore following error
            
        end
        function res = GetSoftwareLimitConfig(obj)
                res = obj.ReadCmd('1ZS?');  
                % 4H
                % 
            
        end
        function SetSoftwareLimitConfig(obj, val)
                 obj.WriteCmd(['1ZS' char(string(val))]);   % 6H will disable motor  
            % set to 7 and it will silently ignore commands that try
            % to send it past the software limits
        end
        function res = GetHardwareLimitConfig(obj)
                res = obj.ReadCmd('1ZH?');  

            
        end
        function SetHardwareLimitConfig(obj, val)
                 obj.WriteCmd(['1ZH' char(string(val))]);   
        end
        function res = GetSerialProperties(obj)
            res = get(obj.serialPort);
            
        end
        function DefineHome(obj)
            obj.WriteCmd('1DH');        
        end
        function res = ReadActualPosition(obj)
            res = obj.ReadCmd('1TP?');
        end
        function res = ReadDesiredPosition(obj)
            res = obj.ReadCmd('1DP?');          
        end
    end
    
    methods(Access = private)
        function FlushInputBuffer(obj)
         N = obj.serialPort.BytesAvailable();
        while (N~=0)
            fread(obj.serialPort, N);
            N = obj.serialPort.BytesAvailable();               
        end           

        end
        function BlockWhileMoving(obj)
        while (obj.IsMoving())
            pause(0.5);
        end      
        end
        function res = IsMoving(obj)
        val = obj.ReadCmd('1md?');
        if length(val) == 0
            res = 1;
        else
            res = (str2num(val) == 0);
        end

        end
        function WriteCmd(obj, cmd)
            fprintf(obj.serialPort,cmd);              
        end
        function res = ReadCmd(obj, cmd)
            % flush the buffer
            obj.FlushInputBuffer();
            res = query(obj.serialPort, cmd); %2 IS mm, 3 is um
         
        end       
    end
  
end


% can send commands to the actuator and the are executed
% can not receive timely information from the device
% often ask for position information but receive the reply from a previous 
% query
%
% when the device is turned on it has an internal position counter which is
% set to 0, it has to be homed (go to the home switch) and this provides a
% external reference point

% 1mo  turns motor on - have to do this before issuing commands
% 1mf  turns motor off
% 1or2 does a search for the home switch
% 1md?  1 is not moving 0 if moving in PA or PR 
% 1pa3.0  absolute position movement to 3.0
% lpa?    what is the current absolute position
% 1pr2.0  relative position movement by +2.0
% 1mt+    goto + harware limit
% 1mt-    goto - hardware limit
% tb      gives error