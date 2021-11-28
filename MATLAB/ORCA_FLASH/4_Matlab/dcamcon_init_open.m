function [err, hdcam, DCAM] = dcamcon_init_open(bRelay, bDebug)
% dcamcon_init  loads DCAMAPI of RELAY DLL, creates a DCAM object, provides
% a HDCAM handle
% param bRelay:     uses the relay.dll to interecept commands to DCAM
% param bDebug:     does not call DCAM but just debug code in relay dll
    err = -1;
    hdcam = 0;
    DCAM = DCAMSDK(bRelay, bDebug);
    disp('loaded DCAM');
    data = C_INT32_ARRAY_();
    guid = C_DCAM_GUID_();
    init = C_DCAMAPI_INIT_(0,0,data.SizeOf(), data, guid);
    [err, init] = DCAM.dcamapi_init(init);
    clear init guid data;
    if err < 0
        return;
    end
    deviceToUse = 0;
    open = C_DCAMDEV_OPEN_(deviceToUse);
    [err, open] = DCAM.dcamdev_open(open);
    hdcam = open.GetHDCAM();
    clear open;
    if err < 0
        return
    end
end