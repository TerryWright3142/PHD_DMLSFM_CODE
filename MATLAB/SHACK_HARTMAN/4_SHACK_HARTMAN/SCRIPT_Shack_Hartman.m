%SCRIPT_Shack_Hartman
%OK 18/5/18
image_file_path = 'C:/Users/BHFuser/Desktop/Terry_Matlab_Equipment_Code/SHACK_HARTMAN/2_SAMPLES/synchronous_acquisition_image_1000.himg';
sh = Shack_Hartman() ;
sh.Init();
phase = sh.PhaseFromFileImage(image_file_path);
imagesc(phase);
colorbar;
sh.Shutdown();

