mm = load('InfFunctions_HSDM97-15-014.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find the back focus
f_tube = 150;
M = 40;
NA1 = 0.85;
n1 = 1;
f2 = f_tube/M;
f1 = f2*n1;
alpha1 = asin(NA1/n1);
mirrorSN = 'HSDM97-15-014';
back_pupil_radius = 1.5*f1*sin(alpha1);
dm_radius = 13.5/2;
d_theta = 10;
theta = d_theta * pi/180;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath( [pwd '/Wrapper/'] );
dm = asdkDM(mirrorSN);
nbAct = dm.Get( 'NbOfActuator' );
mInf = mm.InfFunctionResults.influenceMatrix;
pupil = ones(size(mm.wfMask));
wPupil = ~isnan(mm.wfMask);
nModes = nbAct;%%%%the number of modes might not be the number of actuators
phase2cmd = pinv2(mInf, nModes);
z = input('enter defocus: ');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 dx = 0.085;
 dy = -0.020;
while abs(z)<100
%  dx = input('dx ');
%  dy = input('dy ');
[Y,X]   = meshgrid(linspace(-1,1,size(mm.wfMask,1)));
X = X + dx;
Y = Y + dy;
scale = back_pupil_radius/dm_radius;
R2       = (X/scale*cos(theta)).^2+(Y/scale).^2;
R  = sqrt(R2);
 
%%function1
target = z*n1*sqrt(1-R2*sin(alpha1)^2)*1000;  
B1 = (-z*sqrt(1-(2-R).^2*sin(alpha1)^2)+2*z*cos(alpha1))*1000; 
target(R > 1) = B1(R>1);
B3 = ((2*z*cos(alpha1) - z)*ones(size(B1)))*1000;
target(R > 2) =  B3(R>2);


%%function2  
% target = z*n1*sqrt(1-R2*sin(alpha1)^2)*1000;  
% target(R > 1) =  0;



target(~wPupil)=NaN;
   
%target = target - mean(target(R2<1));

target = target - mean(target(wPupil));
%     imagesc(target)
%     colorbar
%      xx = 0:0.1:3;
%      yy = z*n1*sqrt(1-xx.^2*sin(alpha1)^2);  
%      yy1 = -z*sqrt(1-(2-xx).^2*sin(alpha1)^2)+2*z*cos(alpha1);
%      yy(xx > 1) =  yy1(xx>1);
%      yy(xx > 2) = 2*z*cos(alpha1) - z;
%      plot(xx,yy);

cmd = target(wPupil)'*phase2cmd;
cmd(cmd>1)=1;
cmd(cmd<-1) = -1;
actual = nan(size(mm.wfMask));
actual(wPupil) = cmd*mInf;
res = actual - target;
     %it looks like std dev is too large
%      [std(res(wPupil)) 0.550/14]
%     % actual(R2>1) = NaN;
%     figure
%      imagesc(target);
%      colorbar
% figure
% imagesc(actual)
% colorbar
plot (cmd)
% figure
% imagesc(res)
% colorbar


dm.Send(cmd);
std(res(R2<1))

z = input('enter defocus: ');
end
dm.Reset( );
disp('exiting connection with the dm');
clear dm;
% clear nbAct target cmd actual;