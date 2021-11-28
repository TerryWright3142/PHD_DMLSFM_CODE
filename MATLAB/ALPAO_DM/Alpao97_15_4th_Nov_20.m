%5_11_20 OK
% this is a slimmed down version of the earlier class with many functions
% etc removed
% the most notbale changes is that there is the fixing of an error in the
% LS circle code which missed out a part of the edge of the pupil.
% Also a correction to a bug in the mapping of the objective pupil to the
% DM

% the class needs to know the radius of the DM, and assumes that there is a
% x2 telescope between the objective pupil and the DM.

% frames of reference are:
% x1,y1 (mm)  frame centred on the pupil of the objective, origin on the
% axis of the objective
% x2,y2 (mm)  after the telescope and also displaced X,Y (mm) - the centre
% of the DM compared with the optical axis of the system
% x3,y3 (mm) centred on the same plane as x2,y2 but rotated by theta_x and
% theta_y to provide tilt and tip:  so this is really DM space. A subset of
% this space will get passed through the influence matrix of the DM
% x4,y4 (AU 1:128, 1:128) this rescales and centres the axis of the DM at
% the centre of the pupil on the influence matrix (which is given by
% dm.wPupil and caculated by the LS circle to give x0,y0,r

% the function used in dm.GetSurfaceFromFunction(obj, fn), assumes x1,y1,r
% (mm) and is the wavefront aberration W(x1,y1) in the exit pupil of the
% objective.
classdef Alpao97_15_4th_Nov_20 < handle
    properties
        % PHASE and OPL used synonymously
        DM %handle to the Alpao SDK used in mex code provided by Alpao
        mirrorSN = 'HSDM97-15-014'; %change SN for different DM       
        mm =load('InfFunctions_HSDM97-15-014.mat'); %influence function, change for a different DM
        mInf;  %influence matrix from Alpao
        nbAct; %number of actuators
        wPupil   % 128x128 1s for the pupil and 0 elsewhere - this was the size of the SH used for measuring the influence functions of this DM
        phase2cmd  % tranformation matrix, turns a OPL into cmds
              
        bestFlat;  %best flat commands
        bBestFlat; %are we using the best flat or the factory flat
        szBestFlat; %location of saved best flat
        
       
        theta_x;
        theta_y,
        X;
        Y;
        LS_x0;
        LS_y0;
        LS_r;
        
        R_dm;
        M;
        NA;
        n;
        
        bRemovePiston;
    end
    methods
        function obj = Alpao97_15_4th_Nov_20()
            %12_1_20  OK
            obj.mInf = obj.mm.InfFunctionResults.influenceMatrix; %load influence matrix 97x11674, each row is a SH image of the actuator set to 1
            obj.wPupil = ~isnan(obj.mm.wfMask);%load pupil 1 inside pupil, 0 outside  sum(pupil==1) = 11674
% obj.szBestFlat = 'best_acts_24-Mar-2021.mat';%_____2021.4.9
% % obj.szBestFlat = 'best_acts_09-Apr-2021.mat';%%4.26 bijiaohaode
%             obj.szBestFlat = 'best_acts_29-Apr-2021.mat';%'best_acts_26-Jan-2021.mat';best_acts_24-Mar-2021.mat
            obj.szBestFlat = 'best_acts_14-Sep-2021.mat';%'best_acts_26-Jan-2021.mat';%'best_acts_28_6.mat';
            obj.bBestFlat = true; %true if the DM is to load an on file bestFlat to replace the factory flat and all phase calculations will include this best flat
            obj.X = 0.5; %displacement of the optical axis from the DM centre relative to the DMs coordinate 
            obj.Y = -0.2; 
            obj.theta_x = 18; % angle between the normal of the DM and the optical axis, in optic table plane
            obj.theta_y = 0; % as above but in plane perpendicular to the optical table
       
            obj.R_dm = 13.5/2;  %radius of the pupil of the DM
            obj.M = 40;
            obj.NA = 0.85; %0.80;
            obj.n = 1; %1.333;
            obj.bRemovePiston = true;
        end
        function Init(obj)
           %5_11_20  OK
           %loads a handle to the DM, finds the number of actuators and
           %flattens
            disp('INIT DM');
            obj.DM = asdkDM(obj.mirrorSN);  %%%creats an Aplao SDK object and store reference to it in DM
            obj.nbAct = obj.DM.Get( 'NbOfActuator' ); %%ask for the number of actuators
            fprintf('Num Actuators : %d \n', obj.nbAct);
                       
            %load bestFlat if required
            disp('BEST FLAT');
            mat = load(obj.szBestFlat);
            obj.bestFlat = mat.best_acts; %on file best flat commands 1x97
            if obj.bBestFlat 
                disp('ALPAO shack hartman determined best flat');
                disp(obj.szBestFlat);
            else
                disp('ALPAO factory flat');
            end 

            obj.phase2cmd = pinv2(obj.mInf, obj.nbAct);%11674x97 matrix
            obj.FitLSCircle(obj.mm.wfMask);
            obj.Flatten();          
        end 
        function Shutdown(obj) 
            obj.DM.Reset( ); 
            obj.DM = [];     
        end
        function SetActuators(obj, cmd)
            %5_11_20  OK
            %clamps cmds to +1 to -1 then sends them to the dm
            %does not remove piston or alter the cmds in any way
            %does not allow for the best flat
            cmd = obj.ClampCmds(cmd);    
            obj.DM.Send( cmd  );

            
        end 
        function Poke(obj, act, val)
            %5_11_20  OK
            %sends act = val and rest zero, cmds clamped to  +1 and -1
            cmd = zeros( obj.nbAct, 1 )';
            cmd(act) = val;
            cmd = obj.ClampCmds(cmd); %restrict all of the cmds to [-1 1]
            obj.SetActuators(cmd);          
        end 
        function Flatten(obj)
            %5_11_20  OK
            %is bBestFlat is true then sends the bestFlat cmds to the DM
            %else sends an array of zeros
            if  obj.bBestFlat
                obj.SetActuators(obj.bestFlat); 
            else
                obj.SetActuators(zeros( 1, obj.nbAct));                 
            end          
        end
        %%% for sending pattens repeatedly to the DM
        function SetPattern(obj, cmd, numRepeat)
            % 5_11_20  OK
            % bounds cmd to 1 or -1 then sends commands as a pattern
            % numRepeat = 0 is infinite,  numRepeat = 1 is send once
            % When sending patterns: PEX-292144 support only 1 send (1) or infinite sends (0)
            %
            %since there might be a whole array of cmds for this function
            %do not store currentCmd and currentSurface
            cmd = obj.ClampCmds(cmd);      
            obj.DM.SendPattern(cmd, numRepeat);         
        end
        function Stop(obj)
            %5_11_20  OK
            %stops a command from SendPattern(infinite)
            obj.DM.Stop();
        end 
        %%%
        function phase = SetSurfaceFromFunction(obj, fn)  
            %5_11_20  OK
            phase = obj.GetSurfaceFromFunction(fn);
            cmds = obj.GetCmdsFromSurface(phase);
            obj.SetActuators(cmds);
        end      
        function [h,w] = GetDimensionsOfPupil(obj)
            %5_11_20   OK
            %get the dimensions of the dm pupil
            [h,w] = size(obj.mm.wfMask);
        end
        function phase = GetSurfaceFromFunction(obj, fn)
            % OK 5_11_20
            [X4,Y4]   = meshgrid(linspace(1,128,128), linspace(1,128, 128));
%start with the disk in the influence matrix, recentre and rescale it so
%that it is the size of the disk of the DM ie 13.5/2mm
%now scale the disk for the tilt of the mirror
%correct for the displacement between the centre of the DM and the optical
%axis
%now demagnify by 2 for the effect of the 200, 100mm tube lenses
%we are left with coordinates in mm at the bfp of the objective
%this means that we need functions like f(R/R_bfp, th)  ie the functions
%themselves can be written in normalised radius
%
            Y1 = 0.5*(cos(obj.theta_y * pi/180)*(obj.R_dm/obj.LS_r)*(X4 - obj.LS_y0) + obj.Y);                     
            X1 = 0.5*(cos(obj.theta_x * pi/180)*(obj.R_dm/obj.LS_r)*(Y4 - obj.LS_x0) + obj.X);
                                
            R = sqrt(X1.^2 + Y1.^2);
% % %             imagesc(R);
% % %             colorbar;
           
            th = angle(X1 + j*Y1);
            r_bfp = 180/obj.M*obj.NA;
            phase = fn(R./r_bfp, th); % because function expects normalised radius
            if obj.bRemovePiston 
                phase = obj.RemovePiston(phase); 
            end
        end
        function [error, cmds] = GetError(obj, fn)
            obj.X = 0;
            obj.Y = 0;
            obj.theta_x = 0;
            obj.theta_y = 0;
            obj.bBestFlat = false;
            [X4,Y4]   = meshgrid(linspace(-1,1,128), linspace(-1,1, 128));
            R = sqrt(X4.^2 + Y4.^2);
            th = angle(X4 + j*Y4);
            phase1 = fn(R, th);
            vvv = phase1(obj.wPupil);
            phase1 = phase1 - mean(vvv(:));
            cmds = obj.GetCmdsFromSurface(phase1);
            cmds = obj.ClampCmds(cmds);
            
            %fprintf('max %f    min %f \n', max(cmds(:)), min(cmds(:))); 
            phase2 = obj.GetSurfaceFromCmds(cmds);
            error = phase2 - phase1;
            
            
        end
        function phase = GetSurfaceFromCmds(obj, cmds) 
            % 5_11_20   OK
            % NB must initially remove the best flat cmds, these were offsets that had to be
            % applied so that cmds = 0 corresponds to phase = 0
            if obj.bBestFlat
                cmds = cmds - obj.bestFlat;
            end
            phase = NaN*zeros(size(obj.wPupil));
            phase(obj.wPupil>0) = cmds*obj.mInf; 
        end
        function cmds = GetCmdsFromSurface_NoBestFlat(obj, phase)
            %7_7_21 OK
            phase(~obj.wPupil)=NaN;
            cmds = double(phase(obj.wPupil)'*obj.phase2cmd);
            %clamp cmds to [-1,1]
            %cmds = obj.ClampCmds(cmds);
        end
        function cmds =  GetCmdsFromSurface(obj, phase) 
            %5_11_20  OK
            phase(~obj.wPupil)=NaN;
            cmds = double(phase(obj.wPupil)'*obj.phase2cmd);
            if obj.bBestFlat
                cmds = cmds + obj.bestFlat; %because 0 phase will make 0 cmds which need an offset
            end
            %clamp cmds to [-1,1]
            %cmds = obj.ClampCmds(cmds);                 
        end
%draw information about cmds and surface
        function DrawInfluenceFn(obj, num, mx)
            %5_11_20  OK
            %INFLUENCE FUNCTIONS SEEM TO BE ROTATED THROUGH 90 DEG
            %VERY IMPORTANT BECAUSE OF THE COS ETC
            %draws a particular influence function, scaled by mx
            phase = NaN*zeros(size(obj.wPupil));
            phase(obj.wPupil > 0) = mx*obj.mInf(num, :);
            phase(obj.wPupil <= 0) = 25;
            imagesc(phase);
            colorbar;
            colormap hot;
            drawnow;
        end
%general utility functions
        function [y0, x0, r] = FitLSCircle(obj, phase)
            % 5_11_20 OK
            %find the LS circle from the edge pixels which have NaN
            %neighbours
                [height, width] = size(phase);
                %construct a list of the x and y coordinates of points that have a NaN
                %neighbour
                cnt = 1;
                x_Edges = [];
                y_Edges = [];
                for x = 1 : width
                    if ~isnan(phase(1,x))
                       y_Edges(cnt) = 1;
                       x_Edges(cnt) = x;
                       cnt = cnt + 1;
                    end
                    
                end
                for x = 2 : width-1
                  for  y = 2 : height -1
                      %if the current pixel is NaN then continue
                      if isnan(phase(y,x))
                          continue;
                      end
                      %we have now found a non NaN pixel
                      bNaN = false;
                      %does it have a NaN neighbour
                      for x1 = -1:1:1
                          for y1 = -1:1:1
                           %ignore the central
                           if x1 == 0 && y1 == 0
                               continue;
                           end
                           %found a pixel with NaN neighbour
                           if isnan(phase(y+y1, x+x1))
                               bNaN = true;
                           end
                          end
                      end
                      if bNaN %it has a NaN neighbour
                          %add the x,y to the x_Edges, y_Edges list
                         x_Edges(cnt) = x;
                         y_Edges(cnt) = y;
                         cnt = cnt + 1;    
                    end   
                  end
                end
                %x_Edges, y_Edges how contains a list of all pixels which
                %have a NaN neighbour
                %fit LS models
                % (x^2 + y^2) = -a1X + -a2y  + -a3
                % (x - a1/2)^2 + (y - a2/2)^2 = (a1^2/4 + a2^2/4 - a3)
                % NB I have used different names for coeffic below
                r2 = x_Edges.^2 + y_Edges.^2;
                X = [ones(numel(r2),1), x_Edges', y_Edges'];
                Y = r2';
                beta = (X'*X)\(X')*Y;
                y0 = beta(3)/2;
                x0 = beta(2)/2;
                r = sqrt(x0^2 + y0^2 + beta(1));
                % (x0,y0,r) now have the features of the LS circle
                % draw the edge pixels
                %
                % the SH images are transposes
                obj.LS_x0 = y0;
                obj.LS_y0 = x0;
                obj.LS_r = r;
% % % %                 if bDraw
% % % %                     phase(round(y0),round(x0)) = 0;
% % % %                     fprintf('centre: x:%d, y:%d \n', x0,y0);
% % % %                     for f = 1:cnt-1
% % % %                         % should not need any bounds checking
% % % %                         phase(y_Edges(f), x_Edges(f)) = 1;
% % % %                         %fprintf('%d %d\n',y_Edges(f), x_Edges(f)); 
% % % %                         imagesc(phase);
% % % %                     drawnow();
% % % %                     end
% % % %                     pause(2);
% % % %                     %draw the LS circle from x0,y0,r %%%%%%within bounds
% % % %                     for thet = 0:0.01:2*pi
% % % %                         x = x0 + r*cos(thet);
% % % %                         y = y0 + r*sin(thet);
% % % %                         phase(round(y), round(x)) = 0;
% % % %                         imagesc(phase);
% % % %                         drawnow();
% % % %                     end
% % % %                 end
        end
        function cmds = ClampCmds(obj, cmd)
            %5_11_20  OK
            cmd(cmd>1)=1;
            cmd(cmd<-1) = -1; 
            cmds = cmd;
            
        end
        function phase = RemovePiston(obj, phase_in)
            %5_11_20  OK
            phase = phase_in - mean(phase_in(obj.wPupil));           
        end
    end
end