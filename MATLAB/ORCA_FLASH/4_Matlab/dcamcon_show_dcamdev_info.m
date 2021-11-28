function err = dcamcon_show_dcamdev_info( DCAM, hdcam )
% dcamcon_show_dcamdev_info  lists out the key device info
% param DCAM:  DCAM object
% param hdcam:  hdcam handle object

    sz(1) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_MODEL,[char(32*ones(1,300)) 0]); 
    sz(2) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_CAMERAID,[char(32*ones(1,300)) 0]); 
    sz(3) = C_DCAMDEV_STRING_(DCAM.DCAM_IDSTR_BUS,[char(32*ones(1,300)) 0]); 
    for f = 1:3
        [err, sz(f)] = DCAM.dcamdev_getstring(hdcam, sz(f));

    end
    disp('DEVICE INFO:');
    disp(['model=' sz(1).text]);
    disp(['cameraid=' sz(2).text]);
    disp(['bus=' sz(3).text]);

    clear sz;

end