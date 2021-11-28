%DMLSFM_ALIGN_DM_WITH_OPTICAL_AXIS

Script_Zernike_Modes;
addpath('.\ORCA_FLASH\4_Matlab');
addpath('.\ALPAO_DM');
dllFolder = '.\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = '.\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
libfunctions(winDLL);
INFINITE           = hex2dec('FFFFFFFF');
%
%
%%
disp('Init Alpao DM object');
dm = Alpao97_15_4th_Nov_20(); 
dm.Init();
%
%%
disp('Init Orca Flash camera object');
flash = OrcaFlash(true); 
flash.Init();
flash.SetExposureTime(0.010);
[~, im1] = flash.CaptureImage(1);
imagesc(im1);


%%  get score

%prepare a score object which works out the location of the centre of mass
%of a pinhole

dm.Flatten();
score = Mode(1000,1000,100,100); %check the mode image
[err, im] = flash.CaptureImage(1);
score.FindScore(im);
score = MeanScore(round(score.x_mode), round(score.y_mode),60,60);

%use the score like this:
[err, im] = flash.CaptureImage(1);
score.FindScore(im)

% then  score.mean_x and score.mean_y gives the location of the centre of
% mass
%% 
% apply 5 um of defocus and take an image then apply -5 and take an image;
% find out how much the centre of mass of the central pinhole moves.  Then
% do a grid search over X and Y directions and find the minimum

defocus = 5; %microns
% x_range and y_range are in mm on the DM frame of reference
x_range = -1 : 0.05 : 1; 
y_range = -1 : 0.05 : 1;
[XX,YY] = meshgrid(x_range, y_range);
RR = zeros(size(XX));
% no need for creep pauses because just oscillating the mirror
c_x = 1;
res = [];
def = 2;

for X = x_range
    c_y=1;
    for Y = y_range
        disp([num2str(X) ' ' num2str(Y)]);

        fB = @(r, th) def*BotchF1W(r, th);
        dm.X = X;
        dm.Y = Y;
        phase = dm.SetSurfaceFromFunction(fB);


        [~, im] = flash.CaptureImage(1);
        score.FindScore(im);
        x1 = score.mean_x;
        y1 = score.mean_y;
        
        fB = @(r, th) -def*BotchF1W(r, th);
        dm.X = X;
        dm.Y = Y;
        phase = dm.SetSurfaceFromFunction(fB);

        [~, im] = flash.CaptureImage(1);
        im = double(im);
        im(im<0) = 0;
        score.FindScore(im);
        x2 = score.mean_x;
        y2 = score.mean_y;

        r = sqrt( (x2-x1)^2 + (y2-y1)^2);
        RR(c_y, c_x) = r; % this is the displacement
        res = [res; X Y r];
        c_y=c_y+1;
    end
    c_x = c_x + 1;
end
RR1 = imgaussfilt(RR,2);
imagesc( RR1);
colorbar;
 
% find the minimum
mn = min(RR1(:));
[i_y, i_x] = find(RR1==mn);
disp('minimum results');
fprintf(' x=%d,   y=%d \n', XX(i_y, i_x), YY(i_y, i_x));

x_best = XX(i_y, i_x);
y_best = YY(i_y, i_x);

%%  Shutdown 
disp('Shutdown');
dm.Shutdown();
flash.Shutdown();
unloadlibrary(winDLL);