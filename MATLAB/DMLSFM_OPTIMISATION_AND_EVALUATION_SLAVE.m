%DMLSFM_OPTIMISATION_AND_EVALUATION_SLAVE
%
%
% run the SLAVE after the MASTER has initialised
addpath('.\ORCA_FLASH\4_Matlab');
%include win_mutex.dll with useful Windows API functions
dllFolder = '.\ORCA_FLASH\6_MUTEX DLL\';
winDLL = 'win_mutex';
headerFolder = '.\ORCA_FLASH\3_VS DLL Code\samples\cpp\init_uninit\win_mutex\';
header = 'win_mutex.h';
loadlibrary([dllFolder, winDLL], [headerFolder,  header], 'alias', winDLL);  
libfunctions(winDLL);
INFINITE           = hex2dec('FFFFFFF');
%
%open memory map for IPC with the MASTER
mem_map = cMMap('test.dat');
mem_map.OpenMap(); 
%
%
szExp = '20.12.15_Zernike1'; % directory to store images
szResults = [szExp '_' num2str(mem_map.zeroStageCorrection)]; % zeroStageCorrection was used when finding field curvature and is an additional displacement of the stage beyond the defocus being corrected
mkdir(szResults);
%initialise Flash
flash = InitialiseFlash(mem_map);
[~, im] = flash.CaptureImage(1); 
imagesc(im);
drawnow();
%configure global exposure to prevent letter boxing
bRollingShutter = false;
ConfigureShutterFlash(flash, bRollingShutter);
%configure input trigger from the DM
ConfigureInputTriggerFlash(flash, mem_map);
%INFORM MASTER THAT SLAVE RUNNING
mem_map.Set_bSlaveRunning(1);
%BOTH MASTER AND SLAVE RUNNING
%
%
%
%
if ~mem_map.bEvaluate
    while true
disp('wait for the master');
            while ~(mem_map.Get_slave_state==0)
                pause(0.5);
            end


                flash.DCAM.dcamprop_setvalue(flash.hdcam, flash.DCAM.DCAM_IDPROP_TRIGGERDELAY,  mem_map.Get_pose_change_to_exposure_delay()/1000);
                %CAPTURE OPTIMISATION IMAGES
disp('capture optimisation images');
tic();
                num_frames = mem_map.num_optimise;
                bGlobalExposure = true;
                ConfigureOutputTriggerFlash(flash, bGlobalExposure); %led on
                num_frames_neglect = 2;
                [im, ~] = FlashAquireImages(flash, num_frames, num_frames_neglect, mem_map);
toc()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('analyse optimisation images');
tic();
                %use the image with best image to find location of the
                %pinholes and the background
                r = 20; % ?
                [imBack, points1] = FindPointsAndBackground(1,1,mem_map.cx, mem_map.cy, im(:,:,end));
                stats_values = zeros(size(mem_map.x));
                for f = 1:size(im,3)
                   stats_values(f) = FindMeanStrehl(points1, mem_map.x0, mem_map.y0, mem_map.cx, mem_map.cy, r, im(:,:,f), imBack);                 
                end
                stats_values = stats_values/mem_map.psf_best_score;
                xopt = FindOptimal(mem_map.x, stats_values);
                mem_map.Set_xopt(xopt); %xopt has the optimal amount of amplitude
                fprintf('XOPT = %d\n', xopt);
                %
                mem_map.Set_slave_state(1);
toc()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('capture optimisal images');
tic();
                num_frames = mem_map.num_best;
                bGlobalExposure = true; %led on
                ConfigureOutputTriggerFlash(flash, bGlobalExposure);
                num_frames_neglect = 2;
                [im, flash_timestamps] = FlashAquireImages(flash, num_frames, num_frames_neglect, mem_map);
toc()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('analyse optimal images');
tic();
                imagesc(im(:,:,end));
                title(['max pix:' num2str(max(abs(im(:)))) ' bestscore:' num2str(mem_map.Get_cur_best_score()) ]);
                drawnow();        
                %FIND OPTIMAL STATISTIC
                stats_values1 = zeros(1, size(im,3));
                for f = 1:size(im,3)
                    stats_values1(f) = FindMeanStrehl(points1,  mem_map.x0, mem_map.y0, mem_map.cx, mem_map.cy, r, im(:,:,f), imBack);                  
                end
                stats_values1 = stats_values1/mem_map.psf_best_score;
                strehl_evaluation_mean = mean(stats_values1(4:end)); % first few images are bad due to odd behaviour of Flash
                fprintf('14 strehl_evaluation_mean:%d, cur_best_score:%d\n', strehl_evaluation_mean, mem_map.Get_cur_best_score());
                if strehl_evaluation_mean > mem_map.Get_cur_best_score() &&  strehl_evaluation_mean > 0 
                    mem_map.Set_cur_best_score(strehl_evaluation_mean);
                    fprintf('IMPROVED best_score:%d\n', mem_map.Get_cur_best_score());
                    mem_map.Set_bImprovement(1); %show that there has been an improvement
                end
                mem_map.Set_slave_state(2);
 toc();
                         
    end
else
        %%%%%EVALUATION
    while true
            disp('0. wait for the master');
                while ~(mem_map.Get_slave_state==0)
                    pause(0.5);
                end
            disp('0. end');
            flash.DCAM.dcamprop_setvalue(flash.hdcam, flash.DCAM.DCAM_IDPROP_TRIGGERDELAY,  mem_map.Get_pose_change_to_exposure_delay()/1000);
                     
            disp('capture optimised images');
            %FIND OPTIMAL IMAGES
            num_frames = mem_map.num_evaluate;
            bGlobalExposure = true; %led on
            ConfigureOutputTriggerFlash(flash, bGlobalExposure);
            num_frames_neglect = 2;
            [im, flash_timestamps] = FlashAquireImages(flash, num_frames, num_frames_neglect, mem_map);
            imm = im(:,:,end);
            imagesc(imm);
            title(['max pix:' num2str(max(abs(imm(:))))]);
            drawnow();
            %SAVE OPTIMAL IMAGES   
            disp('save optimised images');
                for f = 1 : size(im, 3)
                    % only save the 20th image to save memory
                    if f == 20
                     imwrite(im(:,:,f), [szResults '/' num2str(mem_map.Get_current_defocus()) '_' num2str(f) '.tiff']);            
                    end

                end

            
            mem_map.Set_slave_state(2);
            
       
    end  

end


    




%%
flash.Shutdown();
unloadlibrary(winDLL);
disp('Shutdown');
clear;


