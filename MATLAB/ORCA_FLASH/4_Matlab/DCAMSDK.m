classdef DCAMSDK < handle
    properties
        bRelay;
        Debug
        dll;
        
        dllFolder_Relay = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\2_RELAY DLL For Debugging\';
        headerFolder_Relay = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\3_VS DLL Code\samples\cpp\flash_relay\';
        header_Relay = 'flash_relay.h';
        dll_Relay = 'FLASHRELAY';
        dllFolder_DCAM = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\1_DCAM DLL\';
        headerFolder_DCAM = 'C:\Users\BHFuser\Desktop\Terry_Matlab_Equipment_Code\ORCA_FLASH\3_VS DLL Code\samples\cpp\flash_relay\'; %same header folder
        header_DCAM = 'flash.h'; %not finished yet some stuff still commented out
        dll_DCAM = 'dcamapi';
    end
    methods
        function    obj = DCAMSDK(bRelay, bDebug)
                    %disp('load');
                    obj.bRelay = bRelay; 
                    obj.Debug = bDebug;
                    obj.dll = 'DCAM';
                    if bRelay
                        %folders for the dll and header of the relay dll
                        loadlibrary([obj.dllFolder_Relay, obj.dll_Relay], [obj.headerFolder_Relay,  obj.header_Relay], 'alias', obj.dll);
                    else
                        %folders of the DCAM dll etc
                        loadlibrary([obj.dllFolder_DCAM, obj.dll_DCAM], [obj.headerFolder_DCAM,  obj.header_DCAM], 'alias', obj.dll);  
                    end
        end      
        function    delete(obj ...
                    )
                    %disp('unload the dll');
                    unloadlibrary(obj.dll);
        end  
        function    setDebug(obj, bDebug)
                    obj.Debug = bDebug;
        end
        
        
        
        function CreateMetaData(obj, number_of_metadata)
            calllib(obj.dll, 'CreateMetaData', number_of_metadata);
        end
        function DeleteMetaData(obj)
            calllib(obj.dll, 'DeleteMetaData');            
        end
        function AttachMetaData(obj, hdcam, number_of_metadata)
             calllib(obj.dll, 'AttachMetaData',  hdcam, number_of_metadata);           
        end
        function GetMetaData(obj, hdcam, number_of_metadata,frameID, sec, us) 
             calllib(obj.dll, 'GetMetaData', hdcam, number_of_metadata,frameID, sec, us); 
        end
    
    
    
        function    [DCAMERR, C_DCAMAPI_INIT] = dcamapi_init( obj, ...
                    C_DCAMAPI_INIT ...
                )
            % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamapi_init', C_DCAMAPI_INIT.GetPtr(), obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamapi_init', C_DCAMAPI_INIT.GetPtr()) ;  
                    end
                    C_DCAMAPI_INIT.Refresh(); 
   
        end
        function    DCAMERR = dcamapi_uninit(obj ...
                    )
                     if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamapi_uninit', obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamapi_uninit');
                    end           
        end
        function    [DCAMERR, C_DCAMDEV_OPEN] = dcamdev_open( obj, ...
                    C_DCAMDEV_OPEN ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamdev_open', C_DCAMDEV_OPEN.GetPtr(), obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamdev_open' , C_DCAMDEV_OPEN.GetPtr());
                    end 

                    C_DCAMDEV_OPEN.Refresh();
            
        end
        function    DCAMERR = dcamdev_close( obj, ...
                    hdcam ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamdev_close', hdcam, obj.Debug);
                    else
                            DCAMERR = calllib(obj.dll, 'dcamdev_close', hdcam);
                    end          
        end
        function    [DCAMERR , C_DCAMDEV_CAPABILITY] = dcamdev_getcapability( obj, ...
                    hdcam, ...
                    C_DCAMDEV_CAPABILITY ...
                )
            %DEBUG OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamdev_getcapability', hdcam, C_DCAMDEV_CAPABILITY.GetPtr(), obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamdev_getcapability' , hdcam,  C_DCAMDEV_CAPABILITY.GetPtr());
                    end 

                    C_DCAMDEV_CAPABILITY.Refresh();
        end
        function    [DCAMERR, C_DCAMDEV_STRING] = dcamdev_getstring( obj, ...
                    hdcam, ...
                    C_DCAMDEV_STRING ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamdev_getstring', hdcam, C_DCAMDEV_STRING.GetPtr(), obj.Debug);  
                    else
                        DCAMERR = calllib(obj.dll, 'dcamdev_getstring', hdcam, C_DCAMDEV_STRING.GetPtr());   
                    end
                    C_DCAMDEV_STRING.Refresh();
        end
        function    [DCAMERR, pValue] = dcamprop_getvalue( obj,...
                    hdcam, ...
                    iProp, ...
                    pValue ...
                )
                        % FULL TESTED OK
                    x = libpointer('doublePtr', pValue);
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamprop_getvalue', hdcam, iProp, x , obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamprop_getvalue', hdcam, iProp, x);
                    end  
                    pValue = x.Value();
                    clear x; % make sure this happens
        end
        function    DCAMERR = dcambuf_alloc( obj, ...
                    hdcam, ...
                    framecount ...
                )
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcambuf_alloc', hdcam, framecount, obj.Debug);
                    else

                            DCAMERR = calllib(obj.dll, 'dcambuf_alloc', hdcam, framecount);
                    end
        end
        function    DCAMERR = dcambuf_release( obj, ...
                    hdcam, ...
                    iKind ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                             DCAMERR = calllib(obj.dll, 'Dcambuf_release', hdcam, iKind, obj.Debug);
                    else

                             DCAMERR = calllib(obj.dll, 'dcambuf_release', hdcam, iKind);
                    end
        end
        function    [DCAMERR, C_DCAMBUF_FRAME] = dcambuf_lockframe( obj, ...
                    hdcam, ...
                    C_DCAMBUF_FRAME ...
                )  
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcambuf_lockframe', hdcam, C_DCAMBUF_FRAME.GetPtr(),  obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcambuf_lockframe', hdcam, C_DCAMBUF_FRAME.GetPtr());
                    end 
                    C_DCAMBUF_FRAME.Refresh();
                    %pixel_buf = libpointer('uint16Ptr', C_DCAMBUF_FRAME.GetPtr().Value.buf);
                    % setdatatype(pixel_buf, 'uint16Ptr', C_DCAMBUF_FRAME.width, C_DCAMBUF_FRAME.height); %this acts in place
                    % this is immutable it cannot be changed once set
                   % the pixels themselves can be obtained with
                   % pixels = pixel_buf.Value;   
        end
        function    [DCAMERR, C_DCAMWAIT_OPEN] = dcamwait_open( obj, ...
                    C_DCAMWAIT_OPEN ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamwait_open', C_DCAMWAIT_OPEN.GetPtr(), obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamwait_open', C_DCAMWAIT_OPEN.GetPtr());
                    end
                    C_DCAMWAIT_OPEN.Refresh();
        end
        function    DCAMERR = dcamwait_close( obj, ...
                    hwait ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamwait_close', hwait, obj.Debug);
                    else
                        DCAMERR = calllib(obj.dll, 'dcamwait_close', hwait);
                    end
        end
        function    [DCAMERR, C_DCAMCAP_TRANSFERINFO] = dcamcap_transferinfo( obj, ...
                    hdcam, ...
                    C_DCAMCAP_TRANSFERINFO ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamcap_transferinfo', hdcam, C_DCAMCAP_TRANSFERINFO.GetPtr(), obj.Debug);
                    else   
                            DCAMERR = calllib(obj.dll, 'dcamcap_transferinfo', hdcam, C_DCAMCAP_TRANSFERINFO.GetPtr());
                    end

                    C_DCAMCAP_TRANSFERINFO.Refresh();
        end
        function    DCAMERR = dcamcap_start( obj, ...
                    hdcam, ...
                    mode ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                        DCAMERR = calllib(obj.dll, 'Dcamcap_start',hdcam, mode, obj.Debug);
                    else

                        DCAMERR = calllib(obj.dll, 'dcamcap_start', hdcam, mode);
                    end
        end
        function    DCAMERR = dcamcap_stop( obj, ...
                    hdcam ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamcap_stop', hdcam, obj.Debug);
                    else   
                            DCAMERR = calllib(obj.dll, 'dcamcap_stop', hdcam);
                    end
        end
        function    [DCAMERR, C_DCAMWAIT_START] = dcamwait_start( obj, ...
                    hwait, ...
                    C_DCAMWAIT_START ...
                )
                        % FULL TESTED OK
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamwait_start', hwait, C_DCAMWAIT_START.GetPtr(), obj.Debug);
                    else

                            DCAMERR = calllib(obj.dll, 'dcamwait_start', hwait, C_DCAMWAIT_START.GetPtr());
                    end
                    C_DCAMWAIT_START.Refresh();
        end
        function    [DCAMERR, C_DCAMPROP_ATTR] = dcamprop_getattr( obj, ...
                    hdcam, ...
                    C_DCAMPROP_ATTR ...
                )
                    % not tested
                    if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_getattr', hdcam, C_DCAMPROP_ATTR.GetPtr(), obj.Debug);
                    else

                            DCAMERR = calllib(obj.dll, 'dcamprop_getattr', hdcam, C_DCAMPROP_ATTR.GetPtr());
                    end
                    C_DCAMPROP_ATTR.Refresh();
            
        end
        function    DCAMERR = dcamprop_setvalue( obj, ...
                    hdcam, ...
                    iProp, ...
                    fValue ...
                )
            %not tested
                        if obj.bRelay
                                DCAMERR = calllib(obj.dll, 'Dcamprop_setvalue', hdcam, iProp, fValue, obj.Debug);
                        else

                                DCAMERR = calllib(obj.dll, 'dcamprop_setvalue', hdcam, iProp, fValue);
                        end
 
        end
        function    [DCAMERR, pValue] = dcamprop_setgetvalue( obj, ...
                    hdcam, ...
                    iProp, ...
                    pValue, ...
                    option ...
                )
                        x = libpointer('doublePtr', pValue);
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_setgetvalue', hdcam, iProp, x , option, obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamprop_setgetvalue', hdcam, iProp, x, option);
                        end  
                        pValue = x.Value();
                        clear x; % make sure this happens
        end
        function    [DCAMERR, pValue] = dcamprop_queryvalue( obj, ...
                    hdcam, ...
                    iProp, ...
                    pValue, ...
                    option ...
                )
                        x = libpointer('doublePtr', pValue);
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_queryvalue', hdcam, iProp, x , option,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamprop_queryvalue', hdcam, iProp, x, option);
                        end  
                        pValue = x.Value();
                        clear x; % make sure this happens
        end
        function    [DCAMERR, pProp] = dcamprop_getnextid( obj, ...
                    hdcam, ...
                    pProp, ...
                    option ...
                )
                        x = libpointer('int32Ptr', pProp);
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_getnextid', hdcam, x, option,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamprop_getnextid', hdcam, x, option);
                        end  
                        pProp = x.Value();
                        clear x; % make sure this happens
        end
        function    [DCAMERR, text] = dcamprop_getname( obj, ...
                    hdcam, ...
                    iProp, ...
                    text, ...
                    textbytes ...
                )
            %not tested
                        buf = int8(text);
                        x = libpointer('voidPtr', buf);
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_getname', hdcam, iProp, x, textbytes,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamprop_getname', hdcam, iProp, x, textbytes);
                        end                      
                        text = char(x.Value);
                        clear x;
        end
        function    [DCAMERR, C_DCAMPROP_VALUETEXT] = dcamprop_getvaluetext( obj, ...
                    hdcam, ...
                    C_DCAMPROP_VALUETEXT ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamprop_getvaluetext', hdcam, C_DCAMPROP_VALUETEXT.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamprop_getvaluetext', hdcam, C_DCAMPROP_VALUETEXT.GetPtr());
                        end 
                        C_DCAMPROP_VALUETEXT.Refresh();
        end
        function    [DCAMERR, C_DCAMDATA_HDR] = dcamdev_setdata( obj, ...
                    hdcam, ...
                    C_DCAMDATA_HDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamdev_setdata', hdcam, C_DCAMDATA_HDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamdev_setdata', hdcam, C_DCAMDATA_HDR.GetPtr());
                        end 
                        C_DCAMDATA_HDR.Refresh();
        end
        function    [DCAMERR, C_DCAMDATA_HDR] = dcamdev_getdata( obj, ...
                    hdcam, ...
                    C_DCAMDATA_HDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamdev_getdata', hdcam, C_DCAMDATA_HDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamdev_getdata', hdcam, C_DCAMDATA_HDR.GetPtr());
                        end 
                        C_DCAMDATA_HDR.Refresh();         
        end
        function    [DCAMERR, C_DCAMBUF_ATTACH] = dcambuf_attach( obj, ...
                    hdcam, ...
                    C_DCAMBUF_ATTACH ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcambuf_attach', hdcam, C_DCAMBUF_ATTACH.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcambuf_attach', hdcam, C_DCAMBUF_ATTACH.GetPtr());
                        end 
                        C_DCAMBUF_ATTACH.Refresh();         
        end
        function    [DCAMERR, C_DCAMBUF_FRAME] = dcambuf_copyframe(obj, ...
                    hdcam, ...
                    C_DCAMBUF_FRAME ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcambuf_copyframe', hdcam, C_DCAMBUF_FRAME.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcambuf_copyframe', hdcam, C_DCAMBUF_FRAME.GetPtr());
                        end 
                        C_DCAMBUF_FRAME.Refresh(); 
        end
        function    [DCAMERR, C_DCAM_METADATAHDR] = dcambuf_copymetadata( obj, ...
                    hdcam, ...
                    C_DCAM_METADATAHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcambuf_copymetadata', hdcam, C_DCAM_METADATAHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcambuf_copymetadata', hdcam, C_DCAM_METADATAHDR.GetPtr());
                        end 
                        C_DCAM_METADATAHDR.Refresh();         
        end
        function    [DCAMERR, pStatus] = dcamcap_status( obj, ...
                    hdcam, ...
                    pStatus ...
                )
                        x = libpointer('int32Ptr', pStatus);
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamcap_status', hdcam, x,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamcap_status', hdcam, x);
                        end                    
                        pStatus = x.Value();
                        clear x;
        end
        function    DCAMERR = dcamcap_firetrigger( obj, ...
                    hdcam, ...
                    iKind ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamcap_firetrigger', hdcam, iKind,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamcap_firetrigger', hdcam, iKind);
                        end            
        end
        function    DCAMERR = dcamcap_record( obj, ...
                    hdcam, ...
                    hrec ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamcap_record', hdcam, hrec,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamcap_record', hdcam, hrec);
                        end          
        end
        function    DCAMERR = dcamwait_abort( obj, ...
                    hwait ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamwait_abort', hwait,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamwait_abort', hwait);
                        end         
        end
        function    [DCAMERR, C_DCAMREC_OPEN] = dcamrec_open( obj, ...
                    C_DCAMREC_OPEN ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_open', C_DCAMREC_OPEN.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_open', C_DCAMREC_OPEN.GetPtr());
                        end 
                        C_DCAMREC_OPEN.Refresh();
        end
        function    DCAMERR = dcamrec_close( obj, ...
                    hrec ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_close', hrec,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_close', hrec);
                        end        
        end
        function    [DCAMERR, C_DCAMREC_FRAME] = dcamrec_lockframe( obj, ...
                    hrec, ...
                    C_DCAMREC_FRAME ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_lockframe', hrec, C_DCAMREC_FRAME.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_lockframe',  hrec, C_DCAMREC_FRAME.GetPtr());
                        end 
                        C_DCAMREC_FRAME.Refresh();       
        end
        function    [DCAMERR, C_DCAMREC_FRAME] = dcamrec_copyframe( obj, ...
                    hrec, ...
                    C_DCAMREC_FRAME ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_copyframe', hrec, C_DCAMREC_FRAME.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_copyframe',  hrec, C_DCAMREC_FRAME.GetPtr());
                        end 
                        C_DCAMREC_FRAME.Refresh();       
        end
        function    [DCAMERR, C_DCAM_METADATAHDR] = dcamrec_writemetadata( obj, ...
                    hrec, ...
                    C_DCAM_METADATAHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_writemetadata', hrec,  C_DCAM_METADATAHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_writemetadata',  hrec,  C_DCAM_METADATAHDR.GetPtr());
                        end 
                        C_DCAM_METADATAHDR.Refresh();         
        end
        function    [DCAMERR, C_DCAM_METADATAHDR] = dcamrec_lockmetadata( obj, ...
                    hrec, ...
                    C_DCAM_METADATAHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_lockmetadata', hrec,  C_DCAM_METADATAHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_lockmetadata',  hrec,  C_DCAM_METADATAHDR.GetPtr());
                        end 
                        C_DCAM_METADATAHDR.Refresh();         
        end
        function    [DCAMERR, C_DCAM_METADATAHDR] = dcamrec_copymetadata( obj, ...
                    hrec, ...
                    C_DCAM_METADATAHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_copymetadata', hrec,  C_DCAM_METADATAHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_copymetadata',  hrec,  C_DCAM_METADATAHDR.GetPtr());
                        end 
                        C_DCAM_METADATAHDR.Refresh();        
        end
        function    [DCAMERR, C_DCAM_METADATABLOCKHDR] = dcamrec_lockmetadatablock( obj, ...
                    hrec, ...
                    C_DCAM_METADATABLOCKHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_lockmetadatablock', hrec,  C_DCAM_METADATABLOCKHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_lockmetadatablock',  hrec,  C_DCAM_METADATABLOCKHDR.GetPtr());
                        end 
                        C_DCAM_METADATABLOCKHDR.Refresh();         
        end
        function    [DCAMERR, C_DCAM_METADATABLOCKHDR] = dcamrec_copymetadatablock( obj, ...
                    hrec, ...
                    C_DCAM_METADATABLOCKHDR ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_copymetadatablock', hrec,  C_DCAM_METADATABLOCKHDR.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_copymetadatablock',  hrec,  C_DCAM_METADATABLOCKHDR.GetPtr());
                        end 
                        C_DCAM_METADATABLOCKHDR.Refresh();           
        end
        function    DCAMERR = dcamrec_pause( obj, ...
                    hrec ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_pause', hrec,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_pause',  hrec);
                        end        
        end
        function    DCAMERR = dcamrec_resume( obj, ...
                    hrec...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_resume', hrec,  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_resume',  hrec);
                        end         
        end
        function    [DCAMERR, C_DCAMREC_STATUS] = dcamrec_status( obj, ...
                    hrec, ...
                    C_DCAMREC_STATUS ...
                )
                        if obj.bRelay
                            DCAMERR = calllib(obj.dll, 'Dcamrec_status', hrec,  C_DCAMREC_STATUS.GetPtr(),  obj.Debug);
                        else
                            DCAMERR = calllib(obj.dll, 'dcamrec_status',  hrec,  C_DCAMREC_STATUS.GetPtr());
                        end 
                        C_DCAMREC_STATUS.Refresh(); 
    end   
    end
    properties (Constant)
        DCAM_DEFAULT_ARG = 0;
        DCAMCAP_START_SEQUENCE				= -1;
        DCAMCAP_START_SNAP					= 0;
        DCAMWAIT_CAPEVENT_FRAMEREADY = 2;
        DCAMWAIT_CAPEVENT_CYCLEEND = 4;
        DCAMWAIT_CAPEVENT_EXPOSUREEND = 8;
        DCAMWAIT_TIMEOUT_INFINITE			= hex2dec('80000000');



        DCAM_IDSTR_BUS						= hex2dec('04000101');;
        DCAM_IDSTR_CAMERAID					= hex2dec('04000102');
        DCAM_IDSTR_VENDOR					= hex2dec('04000103');
        DCAM_IDSTR_MODEL					= hex2dec('04000104');
        DCAM_IDSTR_CAMERAVERSION			= hex2dec('04000105');
        DCAM_IDSTR_DRIVERVERSION			= hex2dec('04000106');
        DCAM_IDSTR_MODULEVERSION			= hex2dec('04000107');
        DCAM_IDSTR_DCAMAPIVERSION			= hex2dec('04000108'); 

        DCAM_IDSTR_CAMERA_SERIESNAME		= hex2dec('0400012c');

        DCAM_IDSTR_OPTICALBLOCK_MODEL		= hex2dec('04001101');
        DCAM_IDSTR_OPTICALBLOCK_ID			= hex2dec('04001102');
        DCAM_IDSTR_OPTICALBLOCK_DESCRIPTION	= hex2dec('04001103');
        DCAM_IDSTR_OPTICALBLOCK_CHANNEL_1	= hex2dec('04001104');
        DCAM_IDSTR_OPTICALBLOCK_CHANNEL_2	= hex2dec('04001105');

        % DCAMPROPOPTION
        % direction flag for dcam_getnextpropertyid(), dcam_querypropertyvalue() ***/
        DCAMPROP_OPTION_PRIOR		= hex2dec('FF000000');
        DCAMPROP_OPTION_NEXT		= hex2dec('01000000');
        %direction flag for dcam_querypropertyvalue() ***/
        DCAMPROP_OPTION_NEAREST		= hex2dec('80000000');
        %option for dcam_getnextpropertyid() ***/
        DCAMPROP_OPTION_SUPPORT		= 0;
        DCAMPROP_OPTION_UPDATED		= 1;
        DCAMPROP_OPTION_VOLATILE	= 2;
        DCAMPROP_OPTION_ARRAYELEMENT= 4;
        DCAMPROP_OPTION_NONE		= 0;

        % DCAMPROPATTRIBUTE
        %supporting information of DCAM_PROPERTYATTR */
        DCAMPROP_ATTR_HASRANGE		= hex2dec('80000000');
        DCAMPROP_ATTR_HASSTEP		= hex2dec('40000000');
        DCAMPROP_ATTR_HASDEFAULT	= hex2dec('20000000');
        DCAMPROP_ATTR_HASVALUETEXT	= hex2dec('10000000');
        %	/* property id information */
        DCAMPROP_ATTR_HASCHANNEL	= hex2dec('08000000');
        %	/* property attribute */
        DCAMPROP_ATTR_AUTOROUNDING	= hex2dec('00800000');
        % 		/* The dcam_setproperty() or dcam_setgetproperty() will failure if this bit exists. */
        % 		/* If this flag does not exist, the value will be round up when it is not supported. */
        DCAMPROP_ATTR_STEPPING_INCONSISTENT= hex2dec('00400000');
        %The valuestep of DCAM_PROPERTYATTR is not consistent across the entire range of	
        %values.


        DCAMPROP_ATTR_DATASTREAM	= hex2dec('00200000');
        DCAMPROP_ATTR_HASRATIO		= hex2dec('00100000');
        DCAMPROP_ATTR_VOLATILE		= hex2dec('00080000');
        DCAMPROP_ATTR_WRITABLE		= hex2dec('00020000');
        DCAMPROP_ATTR_READABLE		= hex2dec('00010000');
        DCAMPROP_ATTR_HASVIEW		= hex2dec('00008000');
        DCAMPROP_ATTR__SYSTEM		= hex2dec('00004000');
        DCAMPROP_ATTR_ACCESSREADY	= hex2dec('00002000');
        DCAMPROP_ATTR_ACCESSBUSY	= hex2dec('00001000');
        DCAMPROP_ATTR_ADVANCED		= hex2dec('00000800');
        DCAMPROP_ATTR_ACTION		= hex2dec('00000400');
        DCAMPROP_ATTR_EFFECTIVE		= hex2dec('00000200');
        %property value type */
        DCAMPROP_TYPE_NONE			= 0	;				
        DCAMPROP_TYPE_MODE			= 1;
        DCAMPROP_TYPE_LONG			= 2;
        DCAMPROP_TYPE_REAL			= 3;				
        % 		/* application has to use double-float type variable even the property is not REAL.	*/
        DCAMPROP_TYPE_MASK			= 15;	

        %DCAMPROPATTRIBUTE2
        % 	/* supporting information of DCAM_PROPERTYATTR */
        DCAMPROP_ATTR2_ARRAYBASE	= hex2dec('08000000');% 
        DCAMPROP_ATTR2_ARRAYELEMENT	= hex2dec('04000000');%
        DCAMPROP_ATTR2_REAL32		= hex2dec('02000000');%
        DCAMPROP_ATTR2_INITIALIZEIMPROPER = hex2dec('00000001');%
        DCAMPROP_ATTR2__FUTUREUSE	= hex2dec('000FFFFC');%

        %property information */
        %DCAMPROPUNIT
        DCAMPROP_UNIT_SECOND		= 1;%			/* sec */
        DCAMPROP_UNIT_CELSIUS		= 2;%			/* for sensor temperature */
        DCAMPROP_UNIT_KELVIN		= 3;%			/* for color temperature */
        DCAMPROP_UNIT_METERPERSECOND= 4;%			/* for LINESPEED */
        DCAMPROP_UNIT_PERSECOND		= 5;%			/* for FRAMERATE and LINERATE */
        DCAMPROP_UNIT_DEGREE		= 6;%			/* for OUTPUT ROTATION */	/* reserved */
        DCAMPROP_UNIT_MICROMETER	= 7;%			/* for length */	/* reserved */
        DCAMPROP_UNIT_NONE			= 0;%

        %DCAMPROPMODEVALUE
        % 	/* DCAM_IDPROP_SENSORMODE */
        DCAMPROP_SENSORMODE__AREA					= 1;%			/*	"AREA"					*/
        DCAMPROP_SENSORMODE__SLIT					= 2;%			/*	"SLIT"					*/	/* reserved */
        DCAMPROP_SENSORMODE__LINE					= 3;%			/*	"LINE"					*/
        DCAMPROP_SENSORMODE__TDI					= 4;%			/*	"TDI"					*/
        DCAMPROP_SENSORMODE__FRAMING				= 5;%			/*	"FRAMING"				*/	/* reserved */
        DCAMPROP_SENSORMODE__PARTIALAREA			= 6;%			/*	"PARTIAL AREA"			*/	/* reserved */
        DCAMPROP_SENSORMODE__SLITLINE				= 9;%			/*	"SLIT LINE"				*/	/* reserved */
        DCAMPROP_SENSORMODE__TDI_EXTENDED			= 10;%			/*	"TDI EXTENDED"			*/
        DCAMPROP_SENSORMODE__PANORAMIC				= 11;%			/*	"PANORAMIC"				*/	/* reserved */
        DCAMPROP_SENSORMODE__PROGRESSIVE			= 12;%			/*	"PROGRESSIVE"			*/	/* reserved */
        DCAMPROP_SENSORMODE__SPLITVIEW				= 14;%			/*	"SPLIT VIEW"			*/	/* reserved */
        DCAMPROP_SENSORMODE__DUALLIGHTSHEET			= 16;%			/*	"DUAL LIGHTSHEET"		*/
        %  
        % 	/* DCAM_IDPROP_READOUTSPEED */
        DCAMPROP_READOUTSPEED__SLOWEST				= 1;%			/*	no text					*/
        DCAMPROP_READOUTSPEED__FASTEST				= hex2dec('7FFFFFFF');%	/*	no text,w/o				*/

        % 	/* DCAM_IDPROP_READOUT_DIRECTION */
        DCAMPROP_READOUT_DIRECTION__FORWARD			= 1;%			/*	"FORWARD"				*/
        DCAMPROP_READOUT_DIRECTION__BACKWARD		= 2;%			/*	"BACKWARD"				*/
        DCAMPROP_READOUT_DIRECTION__BYTRIGGER		= 3;%			/*	"BY TRIGGER"			*/
        DCAMPROP_READOUT_DIRECTION__DIVERGE			= 5;%			/*	"DIVERGE"				*/

        % 	/* DCAM_IDPROP_READOUT_UNIT */
        %/*	DCAMPROP_READOUT_UNIT__LINE					= 1;%	*/		/*	"LINE"					*/	/* reserved */
        DCAMPROP_READOUT_UNIT__FRAME				= 2;%			/*	"FRAME"					*/
        DCAMPROP_READOUT_UNIT__BUNDLEDLINE			= 3;%			/*	"BUNDLED LINE"			*/
        DCAMPROP_READOUT_UNIT__BUNDLEDFRAME			= 4;%			/*	"BUNDLED FRAME"			*/

        % 	/* DCAM_IDPROP_CCDMODE */
        DCAMPROP_CCDMODE__NORMALCCD					= 1;%			/*	"NORMAL CCD"			*/
        DCAMPROP_CCDMODE__EMCCD						= 2;%			/*	"EM CCD"				*/


        % 	/* DCAM_IDPROP_CMOSMODE */
        DCAMPROP_CMOSMODE__NORMAL					= 1;%			/*	"NORMAL"				*/
        DCAMPROP_CMOSMODE__NONDESTRUCTIVE			= 2;%			/*	"NON DESTRUCTIVE"		*/

        % 	/* DCAM_IDPROP_OUTPUT_INTENSITY		 */
        DCAMPROP_OUTPUT_INTENSITY__NORMAL			= 1;%			/*	"NORMAL"				*/
        DCAMPROP_OUTPUT_INTENSITY__TESTPATTERN		= 2;%			/*	"TEST PATTERN"			*/

        % 	/* DCAM_IDPROP_OUTPUTDATA_ORIENTATION	 */													/* reserved */
        DCAMPROP_OUTPUTDATA_ORIENTATION__NORMAL		= 1;%											/* reserved */
        DCAMPROP_OUTPUTDATA_ORIENTATION__MIRROR		= 2;%											/* reserved */
        DCAMPROP_OUTPUTDATA_ORIENTATION__FLIP		= 3;%											/* reserved */
        % 
        % 	/* DCAM_IDPROP_OUTPUTDATA_OPERATION		*/
        DCAMPROP_OUTPUTDATA_OPERATION__RAW			= 1;%
        DCAMPROP_OUTPUTDATA_OPERATION__ALIGNED		= 2;%

        % 	/* DCAM_IDPROP_TESTPATTERN_KIND		 */
        DCAMPROP_TESTPATTERN_KIND__FLAT				= 2;%			/* "FLAT"					*/
        DCAMPROP_TESTPATTERN_KIND__HORZGRADATION	= 4;%			/* "HORZGRADATION"			*/
        DCAMPROP_TESTPATTERN_KIND__IHORZGRADATION	= 5;%			/* "INVERT HORZGRADATION"	*/
        DCAMPROP_TESTPATTERN_KIND__VERTGRADATION	= 6;%			/* "VERTGRADATION"			*/
        DCAMPROP_TESTPATTERN_KIND__IVERTGRADATION	= 7;%			/* "INVERT VERTGRADATION"	*/
        DCAMPROP_TESTPATTERN_KIND__LINE				= 8;%			/* "LINE"					*/
        DCAMPROP_TESTPATTERN_KIND__DIAGONAL			= 10;%			/* "DIAGONAL"				*/
        DCAMPROP_TESTPATTERN_KIND__FRAMECOUNT		= 12;%			/* "FRAMECOUNT"				*/

        % 	/* DCAM_IDPROP_DIGITALBINNING_METHOD */
        DCAMPROP_DIGITALBINNING_METHOD__MINIMUM		= 1;%			/*	"MINIMUM"				*/
        DCAMPROP_DIGITALBINNING_METHOD__MAXIMUM		= 2;%			/*	"MAXIMUM"				*/
        DCAMPROP_DIGITALBINNING_METHOD__ODD			= 3;%			/*	"ODD"					*/
        DCAMPROP_DIGITALBINNING_METHOD__EVEN		= 4;%			/*	"EVEN"					*/
        DCAMPROP_DIGITALBINNING_METHOD__SUM			= 5;%			/*	"SUM"					*/
        DCAMPROP_DIGITALBINNING_METHOD__AVERAGE		= 6;%			/*	"AVERAGE"				*/

        % 	/* DCAM_IDPROP_TRIGGERSOURCE */
        DCAMPROP_TRIGGERSOURCE__INTERNAL			= 1;%			/*	"INTERNAL"				*/
        DCAMPROP_TRIGGERSOURCE__EXTERNAL			= 2;%			/*	"EXTERNAL"				*/
        DCAMPROP_TRIGGERSOURCE__SOFTWARE			= 3;%			/*	"SOFTWARE"				*/
        DCAMPROP_TRIGGERSOURCE__MASTERPULSE			= 4;%			/*	"MASTER PULSE"			*/

        % 	/* DCAM_IDPROP_TRIGGERACTIVE */
        DCAMPROP_TRIGGERACTIVE__EDGE				= 1;%			/*	"EDGE"					*/
        DCAMPROP_TRIGGERACTIVE__LEVEL				= 2;%			/*	"LEVEL"					*/
        DCAMPROP_TRIGGERACTIVE__SYNCREADOUT			= 3;%			/*	"SYNCREADOUT"			*/
        DCAMPROP_TRIGGERACTIVE__POINT				= 4;%			/*	"POINT"					*/

        % 	/* DCAM_IDPROP_BUS_SPEED */
        DCAMPROP_BUS_SPEED__SLOWEST					= 1;%			/*	no text					*/
        DCAMPROP_BUS_SPEED__FASTEST					= hex2dec('7FFFFFFF');%	/*	no text,w/o				*/

        % 	/* DCAM_IDPROP_TRIGGER_MODE */
        DCAMPROP_TRIGGER_MODE__NORMAL				= 1;%			/*	"NORMAL"				*/
        % 											/*	= 2,	*/
        DCAMPROP_TRIGGER_MODE__PIV					= 3;%			/*	"PIV"					*/
        DCAMPROP_TRIGGER_MODE__START				= 6;%			/*	"START"					*/
        DCAMPROP_TRIGGER_MODE__MULTIGATE			= 7;%			/*	"MULTIGATE"				*/	/* reserved */
        DCAMPROP_TRIGGER_MODE__MULTIFRAME			= 8;%			/*	"MULTIFRAME"			*/	/* reserved */

        % 	/* DCAM_IDPROP_TRIGGERPOLARITY */
        DCAMPROP_TRIGGERPOLARITY__NEGATIVE			= 1;%			/*	"NEGATIVE"				*/
        DCAMPROP_TRIGGERPOLARITY__POSITIVE			= 2;%			/*	"POSITIVE"				*/

        % 	/* DCAM_IDPROP_TRIGGER_CONNECTOR */
        DCAMPROP_TRIGGER_CONNECTOR__INTERFACE		= 1;%			/*	"INTERFACE"				*/
        DCAMPROP_TRIGGER_CONNECTOR__BNC				= 2;%			/*	"BNC"					*/
        DCAMPROP_TRIGGER_CONNECTOR__MULTI			= 3;%			/*	"MULTI"					*/

        % 	/* DCAM_IDPROP_INTERNALTRIGGER_HANDLING */
        DCAMPROP_INTERNALTRIGGER_HANDLING__SHORTEREXPOSURETIME = 1;%	/*	"SHORTER EXPOSURE TIME"	*/
        DCAMPROP_INTERNALTRIGGER_HANDLING__FASTERFRAMERATE	= 2;%	/*	"FASTER FRAME RATE"		*/
        DCAMPROP_INTERNALTRIGGER_HANDLING__ABANDONWRONGFRAME = 3;%	/*	"ABANDON WRONG FRAME"	*/
        DCAMPROP_INTERNALTRIGGER_HANDLING__BURSTMODE		= 4;%	/*	"BURST MODE"			*/
        DCAMPROP_INTERNALTRIGGER_HANDLING__INDIVIDUALEXPOSURE = 7;%	/*	"INDIVIDUAL EXPOSURE TIME"	*/

        % 	/* DCAM_IDPROP_SYNCREADOUT_SYSTEMBLANK */
        DCAMPROP_SYNCREADOUT_SYSTEMBLANK__STANDARD	= 1;%			/*	"STANDARD"				*/
        DCAMPROP_SYNCREADOUT_SYSTEMBLANK__MINIMUM	= 2;%			/*	"MINIMUM"				*/

        % 	/* DCAM_IDPROP_TRIGGERENABLE_ACTIVE */
        DCAMPROP_TRIGGERENABLE_ACTIVE__DENY			= 1;%			/*	"DENY"					*/
        DCAMPROP_TRIGGERENABLE_ACTIVE__ALWAYS		= 2;%			/*	"ALWAYS"				*/
        DCAMPROP_TRIGGERENABLE_ACTIVE__LEVEL		= 3;%			/*	"LEVEL"					*/
        DCAMPROP_TRIGGERENABLE_ACTIVE__START		= 4;%			/*	"START"					*/

        % 	/* DCAM_IDPROP_TRIGGERENABLE_POLARITY */
        DCAMPROP_TRIGGERENABLE_POLARITY__NEGATIVE	= 1;%			/*	"NEGATIVE"				*/
        DCAMPROP_TRIGGERENABLE_POLARITY__POSITIVE	= 2;%			/*	"POSITIVE"				*/
        DCAMPROP_TRIGGERENABLE_POLARITY__INTERLOCK	= 3;%			/*	"INTERLOCK"				*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_CHANNELSYNC */
        DCAMPROP_OUTPUTTRIGGER_CHANNELSYNC__1CHANNEL = 1;%			/*	"1 Channel"				*/
        DCAMPROP_OUTPUTTRIGGER_CHANNELSYNC__2CHANNELS = 2;%			/*	"2 Channels"			*/
        DCAMPROP_OUTPUTTRIGGER_CHANNELSYNC__3CHANNELS = 3;%			/*	"3 Channels"			*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_PROGRAMABLESTART */
        DCAMPROP_OUTPUTTRIGGER_PROGRAMABLESTART__FIRSTEXPOSURE	= 1;%	/*	"FIRST EXPOSURE"		*/
        DCAMPROP_OUTPUTTRIGGER_PROGRAMABLESTART__FIRSTREADOUT	= 2;%	/*	"FIRST READOUT"			*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_SOURCE */
        DCAMPROP_OUTPUTTRIGGER_SOURCE__EXPOSURE		= 1;%			/*	"EXPOSURE"				*/
        DCAMPROP_OUTPUTTRIGGER_SOURCE__READOUTEND	= 2;%			/*	"READOUT END"			*/
        DCAMPROP_OUTPUTTRIGGER_SOURCE__VSYNC		= 3;%			/*	"VSYNC"					*/
        DCAMPROP_OUTPUTTRIGGER_SOURCE__HSYNC		= 4;%			/*	"HSYNC"					*/
        DCAMPROP_OUTPUTTRIGGER_SOURCE__TRIGGER		= 6;%			/*	"TRIGGER"				*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_POLARITY */
        DCAMPROP_OUTPUTTRIGGER_POLARITY__NEGATIVE	= 1;%			/*	"NEGATIVE"				*/
        DCAMPROP_OUTPUTTRIGGER_POLARITY__POSITIVE	= 2;%			/*	"POSITIVE"				*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_ACTIVE */
        DCAMPROP_OUTPUTTRIGGER_ACTIVE__EDGE			= 1;%			/*	"EDGE"					*/
        DCAMPROP_OUTPUTTRIGGER_ACTIVE__LEVEL		= 2;%			/*	"LEVEL"					*/
        % /*	DCAMPROP_OUTPUTTRIGGER_ACTIVE__PULSE		= 3,	*/		/*	"PULSE"					*/	/* reserved */

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_KIND */
        DCAMPROP_OUTPUTTRIGGER_KIND__LOW			= 1;%			/*	"LOW"					*/
        DCAMPROP_OUTPUTTRIGGER_KIND__EXPOSURE		= 2;%			/*	"EXPOSURE"				*/
        DCAMPROP_OUTPUTTRIGGER_KIND__PROGRAMABLE	= 3;%			/*	"PROGRAMABLE"			*/
        DCAMPROP_OUTPUTTRIGGER_KIND__TRIGGERREADY	= 4;%			/*	"TRIGGER READY"			*/
        DCAMPROP_OUTPUTTRIGGER_KIND__HIGH			= 5;%			/*	"HIGH"					*/

        % 	/* DCAM_IDPROP_OUTPUTTRIGGER_BASESENSOR */
        DCAMPROP_OUTPUTTRIGGER_BASESENSOR__VIEW1	= 1;%			/*	"VIEW 1"				*/
        DCAMPROP_OUTPUTTRIGGER_BASESENSOR__VIEW2	= 2;%			/*	"VIEW 2"				*/
        DCAMPROP_OUTPUTTRIGGER_BASESENSOR__ANYVIEW	= 15;%			/*	"ANY VIEW"				*/
        DCAMPROP_OUTPUTTRIGGER_BASESENSOR__ALLVIEWS	= 16;%			/*	"ALL VIEWS"				*/

        % 	/* DCAM_IDPROP_EXPOSURETIME_CONTROL */
        DCAMPROP_EXPOSURETIME_CONTROL__OFF			= 1;%			/*	"OFF"					*/
        DCAMPROP_EXPOSURETIME_CONTROL__NORMAL		= 2;%			/*	"NORMAL"				*/

        % 	/* DCAM_IDPROP_TRIGGER_FIRSTEXPOSURE */
        DCAMPROP_TRIGGER_FIRSTEXPOSURE__NEW			= 1;%			/*	"NEW"					*/
        DCAMPROP_TRIGGER_FIRSTEXPOSURE__CURRENT		= 2;%			/*	"CURRENT"				*/

        % 	/* DCAM_IDPROP_TRIGGER_GLOBALEXPOSURE */
        DCAMPROP_TRIGGER_GLOBALEXPOSURE__NONE		= 1;%			/*	"NONE"				*/
        DCAMPROP_TRIGGER_GLOBALEXPOSURE__ALWAYS		= 2;%			/*	"ALWAYS"			*/
        DCAMPROP_TRIGGER_GLOBALEXPOSURE__DELAYED	= 3;%			/*	"DELAYED"			*/
        DCAMPROP_TRIGGER_GLOBALEXPOSURE__EMULATE	= 4;%			/*	"EMULATE"			*/
        DCAMPROP_TRIGGER_GLOBALEXPOSURE__GLOBALRESET = 5;%			/*	"GLOBAL RESET"		*/

        % 	/* DCAM_IDPROP_FIRSTTRIGGER_BEHAVIOR */
        DCAMPROP_FIRSTTRIGGER_BEHAVIOR__STARTEXPOSURE	= 1;%		/*	"START EXPOSURE"				*/
        DCAMPROP_FIRSTTRIGGER_BEHAVIOR__STARTREADOUT	= 2;%		/*	"START READOUT"				*/

        % 	/* DCAM_IDPROP_MASTERPULSE_MODE */
        DCAMPROP_MASTERPULSE_MODE__CONTINUOUS		= 1;%			/*	"CONTINUOUS"		*/
        DCAMPROP_MASTERPULSE_MODE__START			= 2;%			/*	"START"				*/
        DCAMPROP_MASTERPULSE_MODE__BURST			= 3;%			/*	"BURST"				*/

        % 	/* DCAM_IDPROP_MASTERPULSE_TRIGGERSOURCE */
        DCAMPROP_MASTERPULSE_TRIGGERSOURCE__EXTERNAL	= 1;%			/*	"EXTERNAL"		*/
        DCAMPROP_MASTERPULSE_TRIGGERSOURCE__SOFTWARE	= 2;%			/*	"SOFTWARE"		*/

        % 	/* DCAM_IDPROP_MECHANICALSHUTTER */
        DCAMPROP_MECHANICALSHUTTER__AUTO			= 1;%			/*	"AUTO"					*/
        DCAMPROP_MECHANICALSHUTTER__CLOSE			= 2;%			/*	"CLOSE"					*/
        DCAMPROP_MECHANICALSHUTTER__OPEN			= 3;%			/*	"OPEN"					*/

        % 	/* DCAM_IDPROP_MECHANICALSHUTTER_AUTOMODE */												/* reserved */
        % /*	DCAMPROP_MECHANICALSHUTTER_AUTOMODE__OPEN_WHEN_EXPOSURE	= 1,*/	/* "OPEN WHEN EXPOSURE"	*/	/* reserved */
        % /*	DCAMPROP_MECHANICALSHUTTER_AUTOMODE__CLOSE_WHEN_READOUT	= 2,*/	/* "CLOSE WHEN READOUT"	*/	/* reserved */

        % 	/* DCAM_IDPROP_LIGHTMODE */
        DCAMPROP_LIGHTMODE__LOWLIGHT				= 1;%			/*	"LOW LIGHT"				*/
        DCAMPROP_LIGHTMODE__HIGHLIGHT				= 2;%			/*	"HIGH LIGHT"			*/

        % 	/* DCAM_IDPROP_SENSITIVITYMODE */
        DCAMPROP_SENSITIVITYMODE__OFF				= 1;%			/*	"OFF"					*/
        DCAMPROP_SENSITIVITYMODE__ON				= 2;%			/*	"ON"					*/
        DCAMPROP_SENSITIVITY2_MODE__INTERLOCK		= 3;%			/*	"INTERLOCK"				*/

        % 	/* DCAM_IDPROP_EMGAINWARNING_STATUS */
        DCAMPROP_EMGAINWARNING_STATUS__NORMAL		= 1;%			/*	"NORMAL"				*/
        DCAMPROP_EMGAINWARNING_STATUS__WARNING		= 2;%			/*	"WARNING"				*/
        DCAMPROP_EMGAINWARNING_STATUS__PROTECTED	= 3;%			/*	"PROTECTED"				*/

        % 	/* DCAM_IDPROP_PHOTONIMAGINGMODE */
        DCAMPROP_PHOTONIMAGINGMODE__0				= 0;%			/*	"0"						*/
        DCAMPROP_PHOTONIMAGINGMODE__1				= 1;%			/*	"1"						*/
        DCAMPROP_PHOTONIMAGINGMODE__2				= 2;%			/*	"2"						*/
        DCAMPROP_PHOTONIMAGINGMODE__3				= 3;%			/*	"2"						*/
        % 
        % 	/* DCAM_IDPROP_SENSORCOOLER */
        DCAMPROP_SENSORCOOLER__OFF					= 1;%			/*	"OFF"					*/
        DCAMPROP_SENSORCOOLER__ON					= 2;%			/*	"ON"					*/
        % /*	DCAMPROP_SENSORCOOLER__BEST					= 3,	*/		/*	"BEST"					*/	/* reserved */
        DCAMPROP_SENSORCOOLER__MAX					= 4;%			/*	"MAX"					*/

        % 	/* DCAM_IDPROP_SENSORTEMPERATURE_STATUS */
        DCAMPROP_SENSORTEMPERATURE_STATUS__NORMAL		= 0;%		/*	"NORMAL"				*/
        DCAMPROP_SENSORTEMPERATURE_STATUS__WARNING		= 1;%		/*	"WARNING"				*/
        DCAMPROP_SENSORTEMPERATURE_STATUS__PROTECTION	= 2;%		/*	"PROTECTION"			*/

        % 	/* DCAM_IDPROP_SENSORCOOLERSTATUS */
        DCAMPROP_SENSORCOOLERSTATUS__ERROR4			= -4;%			/*	"ERROR4"				*/
        DCAMPROP_SENSORCOOLERSTATUS__ERROR3			= -3;%			/*	"ERROR3"				*/
        DCAMPROP_SENSORCOOLERSTATUS__ERROR2			= -2;%			/*	"ERROR2"				*/
        DCAMPROP_SENSORCOOLERSTATUS__ERROR1			= -1;%			/*	"ERROR1"				*/
        DCAMPROP_SENSORCOOLERSTATUS__NONE			= 0;%			/*	"NONE"					*/
        DCAMPROP_SENSORCOOLERSTATUS__OFF			= 1;%			/*	"OFF"					*/
        DCAMPROP_SENSORCOOLERSTATUS__READY			= 2;%			/*	"READY"					*/
        DCAMPROP_SENSORCOOLERSTATUS__BUSY			= 3;%			/*	"BUSY"					*/
        DCAMPROP_SENSORCOOLERSTATUS__ALWAYS			= 4;%			/*	"ALWAYS"				*/

        % 	/* DCAM_IDPROP_CONTRAST_CONTROL */															/* reserved */
        % /*	DCAMPROP_CONTRAST_CONTROL__OFF				= 1,	*/		/*	"OFF"					*/	/* reserved */
        % /*	DCAMPROP_CONTRAST_CONTROL__ON				= 2,	*/		/*	"ON"					*/	/* reserved */
        % /*	DCAMPROP_CONTRAST_CONTROL__FRONTPANEL		= 3,	*/		/*	"FRONT PANEL"			*/	/* reserved */

        % 	/* DCAM_IDPROP_REALTIMEAGAINCORRECT_LEVEL */
        DCAMPROP_REALTIMEGAINCORRECT_LEVEL__1		= 1;%			/*	"1"						*/
        DCAMPROP_REALTIMEGAINCORRECT_LEVEL__2		= 2;%			/*	"2"						*/
        DCAMPROP_REALTIMEGAINCORRECT_LEVEL__3		= 3;%			/*	"3"						*/
        DCAMPROP_REALTIMEGAINCORRECT_LEVEL__4		= 4;%			/*	"4"						*/
        DCAMPROP_REALTIMEGAINCORRECT_LEVEL__5		= 5;%			/*	"5"						*/

        % 	/* DCAM_IDPROP_WHITEBALANCEMODE */
        DCAMPROP_WHITEBALANCEMODE__FLAT				= 1;%			/*	"FLAT"					*/
        DCAMPROP_WHITEBALANCEMODE__AUTO				= 2;%			/*	"AUTO"					*/
        DCAMPROP_WHITEBALANCEMODE__TEMPERATURE		= 3;%			/*	"TEMPERATURE"			*/
        DCAMPROP_WHITEBALANCEMODE__USERPRESET		= 4;%			/*	"USER PRESET"			*/

        % 	/* DCAM_IDPROP_DARKCALIB_TARGET */
        DCAMPROP_DARKCALIB_TARGET__ALL				= 1;%			/*	"ALL"					*/
        DCAMPROP_DARKCALIB_TARGET__ANALOG			= 2;%			/*	"ANALOG"				*/

        % 	/* DCAM_IDPROP_SHADINGCALIB_METHOD */
        DCAMPROP_SHADINGCALIB_METHOD__AVERAGE		= 1;%			/*	"AVERAGE"				*/
        DCAMPROP_SHADINGCALIB_METHOD__MAXIMUM		= 2;%			/*	"MAXIMUM"				*/
        DCAMPROP_SHADINGCALIB_METHOD__USETARGET		= 3;%			/*	"USE TARGET"			*/

        % 	/* DCAM_IDPROP_CAPTUREMODE */
        DCAMPROP_CAPTUREMODE__NORMAL				= 1;%			/*	"NORMAL"				*/
        DCAMPROP_CAPTUREMODE__DARKCALIB				= 2;%			/*	"DARK CALIBRATION"		*/
        DCAMPROP_CAPTUREMODE__SHADINGCALIB			= 3;%			/*	"SHADING CALIBRATION"	*/
        DCAMPROP_CAPTUREMODE__TAPGAINCALIB			= 4;%			/*	"TAP GAIN CALIBRATION"	*/
        DCAMPROP_CAPTUREMODE__BACKFOCUSCALIB		= 5;%			/*	"BACK FOCUS CALIBRATION"*/	/* ORCA-D2 */

        % 	/* DCAM_IDPROP_INTERFRAMEALU_ENABLE */
        DCAMPROP_INTERFRAMEALU_ENABLE__OFF			= 1;%			/*	"OFF"					*/
        DCAMPROP_INTERFRAMEALU_ENABLE__TRIGGERSOURCE_ALL = 2;%		/*	"TRIGGER SOURCE ALL"	*/
        DCAMPROP_INTERFRAMEALU_ENABLE__TRIGGERSOURCE_INTERNAL=3;%	/*	"TRIGGER SOURCE INTERNAL ONLY"	*/

        % 	/* DCAM_IDPROP_SUBTRACT_DATASTATUS/DCAM_IDPROP_SHADINGCALIB_DATASTATUS */
        DCAMPROP_CALIBDATASTATUS__NONE				= 1;%			/*	"NONE"					*/
        DCAMPROP_CALIBDATASTATUS__FORWARD			= 2;%			/*	"FORWARD"				*/
        DCAMPROP_CALIBDATASTATUS__BACKWARD			= 3;%			/*	"BACKWARD"				*/
        DCAMPROP_CALIBDATASTATUS__BOTH				= 4;%			/*	"BOTH"					*/

        % 	/* DCAM_IDPROP_TAPGAINCALIB_METHOD */
        DCAMPROP_TAPGAINCALIB_METHOD__AVE			= 1;%			/*	"AVERAGE"				*/
        DCAMPROP_TAPGAINCALIB_METHOD__MAX			= 2;%			/*	"MAXIMUM"				*/
        DCAMPROP_TAPGAINCALIB_METHOD__MIN			= 3;%			/*	"MINIMUM"				*/

        % 	/* DCAM_IDPROP_RECURSIVEFILTERFRAMES */
        DCAMPROP_RECURSIVEFILTERFRAMES__2			= 2;%			/*	"2 FRAMES"				*/
        DCAMPROP_RECURSIVEFILTERFRAMES__4			= 4;%			/*	"4 FRAMES"				*/
        DCAMPROP_RECURSIVEFILTERFRAMES__8			= 8;%			/*	"8 FRAMES"				*/
        DCAMPROP_RECURSIVEFILTERFRAMES__16			= 16;%			/*	"16 FRAMES"				*/
        DCAMPROP_RECURSIVEFILTERFRAMES__32			= 32;%			/*	"32 FRAMES"				*/
        DCAMPROP_RECURSIVEFILTERFRAMES__64			= 64;%			/*	"64 FRAMES"				*/

        % 	/* DCAM_IDPROP_INTENSITYLUT_MODE */
        DCAMPROP_INTENSITYLUT_MODE__THROUGH			= 1;%			/*	"THROUGH"				*/
        DCAMPROP_INTENSITYLUT_MODE__PAGE			= 2;%			/*	"PAGE"					*/
        DCAMPROP_INTENSITYLUT_MODE__CLIP			= 3;%			/*	"CLIP"					*/

        % 	/* DCAM_IDPROP_BINNING */
        DCAMPROP_BINNING__1							= 1;%			/*	"1X1"					*/
        DCAMPROP_BINNING__2							= 2;%			/*	"2X2"					*/
        DCAMPROP_BINNING__4							= 4;%			/*	"4X4"					*/
        DCAMPROP_BINNING__8							= 8;%			/*	"8X8"					*/
        DCAMPROP_BINNING__16						= 16;%			/*	"16X16"					*/

        % 	/* DCAM_IDPROP_COLORTYPE */
        DCAMPROP_COLORTYPE__BW						= 1;%	/*	"BW"					*/
        DCAMPROP_COLORTYPE__RGB						= 2;%	/*	"RGB"					*/
        DCAMPROP_COLORTYPE__BGR						= 3;%	/*	"BGR"					*/
        % 												/* other values are resereved */

        % 	/* DCAM_IDPROP_BITSPERCHANNEL */
        DCAMPROP_BITSPERCHANNEL__8					= 8;%			/*	"8BIT"					*/
        DCAMPROP_BITSPERCHANNEL__10					= 10;%			/*	"10BIT"					*/
        DCAMPROP_BITSPERCHANNEL__12					= 12;%			/*	"12BIT"					*/
        DCAMPROP_BITSPERCHANNEL__14					= 14;%			/*	"14BIT"					*/
        DCAMPROP_BITSPERCHANNEL__16					= 16;%			/*	"16BIT"					*/

        % 	/* DCAM_IDPROP_IMAGEFOOTER_FORMAT */

        % 	/* DCAM_IDPROP_DEFECTCORRECT_MODE */
        DCAMPROP_DEFECTCORRECT_MODE__OFF			= 1;%			/*	"OFF"					*/
        DCAMPROP_DEFECTCORRECT_MODE__ON				= 2;%			/*	"ON"					*/

        % 	/* DCAM_IDPROP_DEFECTCORRECT_METHOD */
        DCAMPROP_DEFECTCORRECT_METHOD__CEILING		= 3;%			/*	"CEILING"				*/
        DCAMPROP_DEFECTCORRECT_METHOD__PREVIOUS		= 4;%			/*	"PREVIOUS"				*/

        % 	/* DCAM_IDPROP_HOTPIXELCORRECT_LEVEL */
        DCAMPROP_HOTPIXELCORRECT_LEVEL__STANDARD	= 1;%			/*	"STANDARD"				*/
        DCAMPROP_HOTPIXELCORRECT_LEVEL__MINIMUM		= 2;%			/*	"MINIMUM"				*/
        DCAMPROP_HOTPIXELCORRECT_LEVEL__AGGRESSIVE	= 3;%			/*	"AGGRESSIVE"			*/

        % 	/* DCAM_IDPROP_SYSTEM_ALIVE */
        DCAMPROP_SYSTEM_ALIVE__OFFLINE				= 1;%			/*	"OFFLINE"				*/
        DCAMPROP_SYSTEM_ALIVE__ONLINE				= 2;%			/*	"ONLINE"				*/

        % 	/* DCAM_IDPROP_TIMESTAMP_MODE */
        DCAMPROP_TIMESTAMP_MODE__NONE				= 1;%			/*	"NONE"					*/
        DCAMPROP_TIMESTAMP_MODE__LINEBEFORELEFT		= 2;%			/*	"LINE BEFORE LEFT"		*/
        DCAMPROP_TIMESTAMP_MODE__LINEOVERWRITELEFT	= 3;%			/*	"LINE OVERWRITE LEFT"	*/
        DCAMPROP_TIMESTAMP_MODE__AREABEFORELEFT		= 4;%			/*	"AREA BEFORE LEFT"		*/
        DCAMPROP_TIMESTAMP_MODE__AREAOVERWRITELEFT	= 5;%			/*	"AREA OVERWRITE LEFT"	*/

        % 	/* DCAM_IDPROP_PACECONTROL_MODE */
        DCAMPROP_PACECONTROL_MODE__OFF				= 1;%			/* "OFF"					*/
        DCAMPROP_PACECONTROL_MODE__INTERVAL			= 2;%			/* "INTERVAL"				*/
        DCAMPROP_PACECONTROL_MODE__THINNING			= 3;%			/* "THINNING"				*/

        % 	/* DCAM_IDPROP_TIMING_EXPOSURE */
        DCAMPROP_TIMING_EXPOSURE__AFTERREADOUT		= 1;%			/*	"AFTER READOUT"			*/
        DCAMPROP_TIMING_EXPOSURE__OVERLAPREADOUT	= 2;%			/*	"OVERLAP READOUT"		*/
        DCAMPROP_TIMING_EXPOSURE__ROLLING			= 3;%			/*	"ROLLING"				*/
        DCAMPROP_TIMING_EXPOSURE__ALWAYS			= 4;%			/*	"ALWAYS"				*/
        DCAMPROP_TIMING_EXPOSURE__TDI				= 5;%			/*	"TDI"					*/

        % 	/* DCAM_IDPROP_TIMESTAMP_PRODUCER */
        DCAMPROP_TIMESTAMP_PRODUCER__NONE				= 1;%		/* "NONE"					*/
        DCAMPROP_TIMESTAMP_PRODUCER__DCAMMODULE			= 2;%		/* "DCAM MODULE"			*/
        DCAMPROP_TIMESTAMP_PRODUCER__KERNELDRIVER		= 3;%		/* "KERNEL DRIVER"			*/
        DCAMPROP_TIMESTAMP_PRODUCER__CAPTUREDEVICE		= 4;%		/* "CAPTURE DEVICE"			*/
        DCAMPROP_TIMESTAMP_PRODUCER__IMAGINGDEVICE		= 5;%		/* "IMAGING DEVICE"			*/

        % 	/* DCAM_IDPROP_FRAMESTAMP_PRODUCER */
        DCAMPROP_FRAMESTAMP_PRODUCER__NONE				= 1;%		/* "NONE"					*/
        DCAMPROP_FRAMESTAMP_PRODUCER__DCAMMODULE		= 2;%		/* "DCAM MODULE"			*/
        DCAMPROP_FRAMESTAMP_PRODUCER__KERNELDRIVER		= 3;%		/* "KERNEL DRIVER"			*/
        DCAMPROP_FRAMESTAMP_PRODUCER__CAPTUREDEVICE		= 4;%		/* "CAPTURE DEVICE"			*/
        DCAMPROP_FRAMESTAMP_PRODUCER__IMAGINGDEVICE		= 5;%		/* "IMAGING DEVICE"			*/

        % 	/* DCAM_IDPROP_CAMERASTATUS_INTENSITY */
        DCAMPROP_CAMERASTATUS_INTENSITY__GOOD				= 1;%	/* "GOOD"					*/
        DCAMPROP_CAMERASTATUS_INTENSITY__TOODARK			= 2;%	/* "TOO DRAK"				*/
        DCAMPROP_CAMERASTATUS_INTENSITY__TOOBRIGHT			= 3;%	/* "TOO BRIGHT"				*/
        DCAMPROP_CAMERASTATUS_INTENSITY__UNCARE				= 4;%	/* "UNCARE"					*/
        DCAMPROP_CAMERASTATUS_INTENSITY__EMGAIN_PROTECTION	= 5;%	/* "EMGAIN PROTECTION"		*/
        DCAMPROP_CAMERASTATUS_INTENSITY__INCONSISTENT_OPTICS= 6;%	/* "INCONSISTENT OPTICS"	*/
        DCAMPROP_CAMERASTATUS_INTENSITY__NODATA				= 7;%	/* "NO DATA"				*/

        % 	/* DCAM_IDPROP_CAMERASTATUS_INPUTTRIGGER */
        DCAMPROP_CAMERASTATUS_INPUTTRIGGER__GOOD			= 1;%	/* "GOOD"					*/
        DCAMPROP_CAMERASTATUS_INPUTTRIGGER__NONE			= 2;%	/* "NONE"					*/
        DCAMPROP_CAMERASTATUS_INPUTTRIGGER__TOOFREQUENT		= 3;%	/* "TOO FREQUENT"			*/

        % 	/* DCAM_IDPROP_CAMERASTATUS_CALIBRATION */
        DCAMPROP_CAMERASTATUS_CALIBRATION__DONE					= 1;%/* "DONE"					*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__NOTYET				= 2;%/* "NOT YET"				*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__NOTRIGGER			= 3;%/* "NO TRIGGER"				*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__TOOFREQUENTTRIGGER	= 4;%/* "TOO FREQUENT TRIGGER"	*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__OUTOFADJUSTABLERANGE	= 5;%/* "OUT OF ADJUSTABLE RANGE"*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__UNSUITABLETABLE		= 6;%/* "UNSUITABLE TABLE"		*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__TOODARK				= 7;%/* "TOO DARK"				*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__TOOBRIGHT			= 8;%/* "TOO BRIGHT"				*/
        DCAMPROP_CAMERASTATUS_CALIBRATION__NOTDETECTOBJECT		= 9;%/* "NOT DETECT OBJECT"		*/

        % 	/*-- for general purpose --*/
        DCAMPROP_MODE__OFF							= 1;%			/*	"OFF"					*/
        DCAMPROP_MODE__ON							= 2;%			/*	"ON"					*/

        % 	/*-- options --*/
        % 
        % 	/* for backward compativilities */

        % 	DCAMPROP_SCAN_MODE__NORMAL			= DCAMPROP_SENSORMODE__AREA;%
        % 	DCAMPROP_SCAN_MODE__SLIT			= DCAMPROP_SENSORMODE__SLIT;%
        % 
        % 	DCAMPROP_SWITCHMODE_OFF				= DCAMPROP_MODE__OFF;%	/*	"OFF"					*/
        % 	DCAMPROP_SWITCHMODE_ON				= DCAMPROP_MODE__ON;%	/*	"ON"					*/
        % 
        % 	DCAMPROP_TRIGGERACTIVE__PULSE		= DCAMPROP_TRIGGERACTIVE__SYNCREADOUT;%		/*	was "PULSE"	*/
        % 
        % 	DCAMPROP_READOUT_DIRECTION__NORMAL	= DCAMPROP_READOUT_DIRECTION__FORWARD;%			/* VALUETEXT was "NORMAL"	*/
        % 	DCAMPROP_READOUT_DIRECTION__REVERSE	= DCAMPROP_READOUT_DIRECTION__BACKWARD;%			/* VALUETEXT was "REVERSE"	*/

        % 	/*-- miss spelling --*/
        % 	DCAMPROP_TRIGGERSOURCE__EXERNAL		= DCAMPROP_TRIGGERSOURCE__EXTERNAL


        % /* **************************************************************** *
        % 
        % 	property ids
        % 
        %   ****************************************************************  */

        %DCAMIDPROP
        % 								/*	  0x00000000 - 0x00100000, reserved						*/

        % /* Group: TIMING */
        DCAM_IDPROP_TRIGGERSOURCE					= hex2dec('00100110');%	/* R/W, mode,	"TRIGGER SOURCE"		*/
        DCAM_IDPROP_TRIGGERACTIVE					= hex2dec('00100120');%	/* R/W, mode,	"TRIGGER ACTIVE"		*/
        DCAM_IDPROP_TRIGGER_MODE					= hex2dec('00100210');%	/* R/W, mode,	"TRIGGER MODE"			*/
        DCAM_IDPROP_TRIGGERPOLARITY					= hex2dec('00100220');%	/* R/W, mode,	"TRIGGER POLARITY"		*/
        DCAM_IDPROP_TRIGGER_CONNECTOR				= hex2dec('00100230');%	/* R/W, mode,	"TRIGGER CONNECTOR"		*/
        DCAM_IDPROP_TRIGGERTIMES					= hex2dec('00100240');%	/* R/W, long,	"TRIGGER TIMES"			*/
        % 											/*	  0x00100250 is reserved */
        DCAM_IDPROP_TRIGGERDELAY					= hex2dec('00100260');%	/* R/W, sec,	"TRIGGER DELAY"			*/
        DCAM_IDPROP_INTERNALTRIGGER_HANDLING		= hex2dec('00100270');%	/* R/W, mode,	"INTERNAL TRIGGER HANDLING"*/
        DCAM_IDPROP_TRIGGERMULTIFRAME_COUNT			= hex2dec('00100280');%	/* R/W, long,	"TRIGGER MULTI FRAME COUNT"*/
        DCAM_IDPROP_SYNCREADOUT_SYSTEMBLANK			= hex2dec('00100290');%	/* R/W, mode,	"SYNC READOUT SYSTEM BLANK" */

        DCAM_IDPROP_TRIGGERENABLE_ACTIVE			= hex2dec('00100410');%	/* R/W, mode,	"TRIGGER ENABLE ACTIVE"	*/
        DCAM_IDPROP_TRIGGERENABLE_POLARITY			= hex2dec('00100420');%	/* R/W, mode,	"TRIGGER ENABLE POLARITY"*/

        DCAM_IDPROP_TRIGGERNUMBER_FORFIRSTIMAGE		= hex2dec('00100810');%	/* R/O, long,	"TRIGGER NUMBER FOR FIRST IMAGE" */
        DCAM_IDPROP_TRIGGERNUMBER_FORNEXTIMAGE		= hex2dec('00100820');%	/* R/O, long,	"TRIGGER NUMBER FOR NEXT IMAGE" */

        DCAM_IDPROP_BUS_SPEED						= hex2dec('00180110');%	/* R/W, long,	"BUS SPEED"				*/

        DCAM_IDPROP_NUMBEROF_OUTPUTTRIGGERCONNECTOR	= hex2dec('001C0010');%	/* R/O, long,	"NUMBER OF OUTPUT TRIGGER CONNECTOR"*/
        DCAM_IDPROP_OUTPUTTRIGGER_CHANNELSYNC		= hex2dec('001C0030');%	/* R/W, mode,	"OUTPUT TRIGGER CHANNEL SYNC"	*/
        DCAM_IDPROP_OUTPUTTRIGGER_PROGRAMABLESTART	= hex2dec('001C0050');%	/* R/W, mode,	"OUTPUT TRIGGER PROGRAMABLE START"	*/
        DCAM_IDPROP_OUTPUTTRIGGER_SOURCE			= hex2dec('001C0110');%	/* R/W, mode,	"OUTPUT TRIGGER SOURCE"		*/
        DCAM_IDPROP_OUTPUTTRIGGER_POLARITY			= hex2dec('001C0120');%	/* R/W, mode,	"OUTPUT TRIGGER POLARITY"	*/
        DCAM_IDPROP_OUTPUTTRIGGER_ACTIVE			= hex2dec('001C0130');%	/* R/W, mode,	"OUTPUT TRIGGER ACTIVE"		*/
        DCAM_IDPROP_OUTPUTTRIGGER_DELAY				= hex2dec('001C0140');%	/* R/W, sec,	"OUTPUT TRIGGER DELAY"		*/
        DCAM_IDPROP_OUTPUTTRIGGER_PERIOD			= hex2dec('001C0150');%	/* R/W, sec,	"OUTPUT TRIGGER PERIOD"		*/
        DCAM_IDPROP_OUTPUTTRIGGER_KIND				= hex2dec('001C0160');%	/* R/W, mode,	"OUTPUT TRIGGER KIND"		*/
        DCAM_IDPROP_OUTPUTTRIGGER_BASESENSOR		= hex2dec('001C0170');%	/* R/W, mode,	"OUTPUT TRIGGER BASE SENSOR" */
        DCAM_IDPROP_OUTPUTTRIGGER_PREHSYNCCOUNT		= hex2dec('001C0190');%	/* R/W, mode,	"OUTPUT TRIGGER PRE HSYNC COUNT" */
        % % 											/*				 - 0x001C10FF for 16 output trigger connector, reserved		*/
        DCAM_IDPROP__OUTPUTTRIGGER					= hex2dec('0000100');%	/* the offset of ID for Nth OUTPUT TRIGGER parameter */

        DCAM_IDPROP_MASTERPULSE_MODE				= hex2dec('001E0020');%	/* R/W, mode,	"MASTER PULSE MODE"			*/
        DCAM_IDPROP_MASTERPULSE_TRIGGERSOURCE		= hex2dec('001E0030');%	/* R/W, mode,	"MASTER PULSE TRIGGER SOURCE"	*/
        DCAM_IDPROP_MASTERPULSE_INTERVAL			= hex2dec('001E0040');%	/* R/W, sec,	"MASTER PULSE INTERVAL"		*/
        DCAM_IDPROP_MASTERPULSE_BURSTTIMES			= hex2dec('001E0050');%	/* R/W, long,	"MASTER PULSE BURST TIMES"	*/

        % /* Group: FEATURE */
        % 	/* exposure period */
        DCAM_IDPROP_EXPOSURETIME					= hex2dec('001F0110');%	/* R/W, sec,	"EXPOSURE TIME"			*/
        DCAM_IDPROP_SYNC_MULTIVIEWEXPOSURE			= hex2dec('001F0120');%	/* R/W, mode,	"SYNCHRONOUS MULTI VIEW EXPOSURE"	*/
        DCAM_IDPROP_EXPOSURETIME_CONTROL			= hex2dec('001F0130');%	/* R/W, mode,	"EXPOSURE TIME CONTROL"	*/
        DCAM_IDPROP_TRIGGER_FIRSTEXPOSURE			= hex2dec('001F0200');%	/* R/W, mode,	"TRIGGER FIRST EXPOSURE"	*/
        DCAM_IDPROP_TRIGGER_GLOBALEXPOSURE			= hex2dec('001F0300');%	/* R/W, mode,	"TRIGGER GLOBAL EXPOSURE"	*/
        DCAM_IDPROP_FIRSTTRIGGER_BEHAVIOR			= hex2dec('001F0310');%	/* R/W, mode,	"FIRST TRIGGER BEHAVIOR"	*/
        DCAM_IDPROP_MULTIFRAME_EXPOSURE				= hex2dec('001F1000');%	/* R/W, sec,	"MULTI FRAME EXPOSURE TIME"	*/
        % 											/*					 - 0x001F1FFF for 256 MULTI FRAME */
        DCAM_IDPROP__MULTIFRAME						= hex2dec('00000010');%	/* the offset of ID for Nth MULTIFRAME */

        % 	/* anti-blooming */
        DCAM_IDPROP_LIGHTMODE						= hex2dec('00200110');%	/* R/W, mode,	"LIGHT MODE"			*/
        % 											/*	  0x00200120 is reserved */

        % 	/* sensitivity */
        DCAM_IDPROP_SENSITIVITYMODE					= hex2dec('00200210');%	/* R/W, mode,	"SENSITIVITY MODE"		*/
        DCAM_IDPROP_SENSITIVITY						= hex2dec('00200220');%	/* R/W, long,	"SENSITIVITY"			*/
        DCAM_IDPROP_SENSITIVITY2_MODE				= hex2dec('00200230');%	/* R/W, mode,	"SENSITIVITY2 MODE"		*/	/* reserved */
        DCAM_IDPROP_SENSITIVITY2					= hex2dec('00200240');%	/* R/W, long,	"SENSITIVITY2"			*/

        DCAM_IDPROP_DIRECTEMGAIN_MODE				= hex2dec('00200250');%	/* R/W, mode,	"DIRECT EM GAIN MODE"	*/
        DCAM_IDPROP_EMGAINWARNING_STATUS			= hex2dec('00200260');%	/* R/O, mode,	"EM GAIN WARNING STATUS"*/
        DCAM_IDPROP_EMGAINWARNING_LEVEL				= hex2dec('00200270');%	/* R/W, long,	"EM GAIN WARNING LEVEL"	*/
        DCAM_IDPROP_EMGAINWARNING_ALARM				= hex2dec('00200280');%	/* R/W, mode,	"EM GAIN WARNING ALARM"	*/
        DCAM_IDPROP_EMGAINPROTECT_MODE				= hex2dec('00200290');%	/* R/W, mode,	"EM GAIN PROTECT MODE"	*/
        DCAM_IDPROP_EMGAINPROTECT_AFTERFRAMES		= hex2dec('002002A0');%	/* R/W, long,	"EM GAIN PROTECT AFTER FRAMES"	*/

        DCAM_IDPROP_MEASURED_SENSITIVITY			= hex2dec('002002B0');%	/* R/O, real,	"MEASURED SENSITIVITY"	*/

        DCAM_IDPROP_PHOTONIMAGINGMODE				= hex2dec('002002F0');%	/* R/W, mode,	"PHOTON IMAGING MODE"	*/

        % 	/* sensor cooler */
        DCAM_IDPROP_SENSORTEMPERATURE				= hex2dec('00200310');%	/* R/O, celsius,"SENSOR TEMPERATURE"	*/
        DCAM_IDPROP_SENSORCOOLER					= hex2dec('00200320');%	/* R/W, mode,	"SENSOR COOLER"			*/
        DCAM_IDPROP_SENSORTEMPERATURETARGET			= hex2dec('00200330');%	/* R/W, celsius,"SENSOR TEMPERATURE TARGET"	*/
        DCAM_IDPROP_SENSORCOOLERSTATUS				= hex2dec('00200340');%	/* R/O, mode,	"SENSOR COOLER STATUS"	*/
        DCAM_IDPROP_SENSORCOOLERFAN					= hex2dec('00200350');%	/* R/W, mode,	"SENSOR COOLER FAN"		*/
        DCAM_IDPROP_SENSORTEMPERATURE_AVE			= hex2dec('00200360');%	/* R/O, celsius,"SENSOR TEMPERATURE AVE"	*/
        DCAM_IDPROP_SENSORTEMPERATURE_MIN			= hex2dec('00200370');%	/* R/O, celsius,"SENSOR TEMPERATURE MIN"	*/
        DCAM_IDPROP_SENSORTEMPERATURE_MAX			= hex2dec('00200380');%	/* R/O, celsius,"SENSOR TEMPERATURE MAX"	*/
        DCAM_IDPROP_SENSORTEMPERATURE_STATUS		= hex2dec('00200390');%	/* R/O, mode,	"SENSOR TEMPERATURE STATUS"	*/
        DCAM_IDPROP_SENSORTEMPERATURE_PROTECT		= hex2dec('00200400');%	/* R/W, mode,	"SENSOR TEMPERATURE MODE"	*/

        %	/* mechanical shutter */
        DCAM_IDPROP_MECHANICALSHUTTER				= hex2dec('00200410');%	/* R/W, mode,	"MECHANICAL SHUTTER"	*/
        DCAM_IDPROP_MECHANICALSHUTTER_AUTOMODE		= hex2dec('00200420');%	/* R/W, mode,	"MECHANICAL SHUTTER AUTOMODE"	*/	/* reserved */

        % 	/* contrast enhance */
        %/*	DCAM_IDPROP_CONTRAST_CONTROL				= hex2dec('00300110');%*/	/* R/W, mode,	"CONTRAST CONTROL"		*/	/* reserved */
        DCAM_IDPROP_CONTRASTGAIN					= hex2dec('00300120');%	/* R/W, long,	"CONTRAST GAIN"			*/
        DCAM_IDPROP_CONTRASTOFFSET					= hex2dec('00300130');%	/* R/W, long,	"CONTRAST OFFSET"		*/
        % 											/*	  0x00300140 is reserved */
        DCAM_IDPROP_HIGHDYNAMICRANGE_MODE			= hex2dec('00300150');%	/* R/W, mode,	"HIGH DYNAMIC RANGE MODE"	*/
        DCAM_IDPROP_DIRECTGAIN_MODE					= hex2dec('00300160');%	/* R/W, mode,	"DIRECT GAIN MODE"		*/

        DCAM_IDPROP_REALTIMEGAINCORRECT_MODE		= hex2dec('00300170');%	/* R/W,	mode,	"REALTIME GAIN CORRECT MODE"	*/
        DCAM_IDPROP_REALTIMEGAINCORRECT_LEVEL		= hex2dec('00300180');%	/* R/W,	mode,	"REALTIME GAIN CORRECT LEVEL"		*/
        DCAM_IDPROP_REALTIMEGAINCORRECT_INTERVAL	= hex2dec('00300190');%	/* R/W,	mode,	"REALTIME GAIN CORRECT INTERVAL"	*/

        % 	/* color features */
        DCAM_IDPROP_VIVIDCOLOR						= hex2dec('00300200');%	/* R/W, mode,	"VIVID COLOR"			*/	/* comment */
        DCAM_IDPROP_WHITEBALANCEMODE				= hex2dec('00300210');%	/* R/W, mode,	"WHITEBALANCE MODE"		*/
        DCAM_IDPROP_WHITEBALANCETEMPERATURE			= hex2dec('00300220');%	/* R/W, color-temp., "WHITEBALANCE TEMPERATURE"	*/
        DCAM_IDPROP_WHITEBALANCEUSERPRESET			= hex2dec('00300230');%	/* R/W, long,	"WHITEBALANCE USER PRESET"		*/
        % 											/*	  0x00300310 is reserved */
        % 
        % /* Group: ALU */
        % 	/* ALU */
        DCAM_IDPROP_INTERFRAMEALU_ENABLE			= hex2dec('00380010');%	/* R/W, mode,	"INTERFRAME ALU ENABLE"	*/
        DCAM_IDPROP_RECURSIVEFILTER					= hex2dec('00380110');%	/* R/W, mode,	"RECURSIVE FILTER"		*/
        DCAM_IDPROP_RECURSIVEFILTERFRAMES			= hex2dec('00380120');%	/* R/W, long,	"RECURSIVE FILTER FRAMES"*/
        DCAM_IDPROP_SPOTNOISEREDUCER				= hex2dec('00380130');%	/* R/W, mode,	"SPOT NOISE REDUCER"	*/
        DCAM_IDPROP_SUBTRACT						= hex2dec('00380210');%	/* R/W, mode,	"SUBTRACT"				*/
        DCAM_IDPROP_SUBTRACTIMAGEMEMORY				= hex2dec('00380220');%	/* R/W, mode,	"SUBTRACT IMAGE MEMORY"	*/
        DCAM_IDPROP_STORESUBTRACTIMAGETOMEMORY		= hex2dec('00380230');%	/* W/O, mode,	"STORE SUBTRACT IMAGE TO MEMORY"	*/
        DCAM_IDPROP_SUBTRACTOFFSET					= hex2dec('00380240');%	/* R/W, long	"SUBTRACT OFFSET"		*/
        DCAM_IDPROP_DARKCALIB_STABLEMAXINTENSITY	= hex2dec('00380250');%	/* R/W, long,	"DARKCALIB STABLE MAX INTENSITY"	*/
        DCAM_IDPROP_SUBTRACT_DATASTATUS				= hex2dec('003802F0');%	/* R/W	mode,	"SUBTRACT DATA STATUS"	*/
        DCAM_IDPROP_SHADINGCALIB_DATASTATUS			= hex2dec('00380300');%	/* R/W	mode,	"SHADING CALIB DATA STATUS"	*/
        DCAM_IDPROP_SHADINGCORRECTION				= hex2dec('00380310');%	/* R/W, mode,	"SHADING CORRECTION"	*/
        DCAM_IDPROP_SHADINGCALIBDATAMEMORY			= hex2dec('00380320');%	/* R/W, mode,	"SHADING CALIB DATA MEMORY"		*/
        DCAM_IDPROP_STORESHADINGCALIBDATATOMEMORY	= hex2dec('00380330');%	/* W/O, mode,	"STORE SHADING DATA TO MEMORY"	*/
        DCAM_IDPROP_SHADINGCALIB_METHOD				= hex2dec('00380340');%	/* R/W, mode,	"SHADING CALIB METHOD"	*/
        DCAM_IDPROP_SHADINGCALIB_TARGET				= hex2dec('00380350');%	/* R/W, long,	"SHADING CALIB TARGET"	*/
        DCAM_IDPROP_SHADINGCALIB_STABLEMININTENSITY	= hex2dec('00380360');%	/* R/W, long,	"SHADING CALIB STABLE MIN INTENSITY"	*/
        DCAM_IDPROP_SHADINGCALIB_SAMPLES			= hex2dec('00380370');%	/* R/W, long,	"SHADING CALIB SAMPLES"	*/
        DCAM_IDPROP_SHADINGCALIB_STABLESAMPLES		= hex2dec('00380380');%	/* R/W, long,	"SHADING CALIB STABLE SAMPLES"	*/
        DCAM_IDPROP_SHADINGCALIB_STABLEMAXERRORPERCENT=hex2dec('00380390');%	/* R/W, long,	"SHADING CALIB STABLE MAX ERROR PERCENT" */
        DCAM_IDPROP_FRAMEAVERAGINGMODE				= hex2dec('003803A0');%	/* R/W, mode,	"FRAME AVERAGING MODE"		*/
        DCAM_IDPROP_FRAMEAVERAGINGFRAMES			= hex2dec('003803B0');%	/* R/W, long,	"FRAME AVERAGING FRAMES"*/
        DCAM_IDPROP_DARKCALIB_STABLESAMPLES			= hex2dec('003803C0');%	/* R/W, long,	"DARKCALIB STABLE SAMPLES"	*/
        DCAM_IDPROP_DARKCALIB_SAMPLES				= hex2dec('003803D0');%	/* R/W, long,	"DARKCALIB SAMPLES"	*/
        DCAM_IDPROP_DARKCALIB_TARGET				= hex2dec('003803E0');%	/* R/W, long,	"DARKCALIB TARGET" */
        DCAM_IDPROP_CAPTUREMODE						= hex2dec('00380410');%	/* R/W, mode,	"CAPTURE MODE"			*/
        DCAM_IDPROP_INTENSITYLUT_MODE				= hex2dec('00380510');%	/* R/W, mode,	"INTENSITY LUT MODE"	*/
        DCAM_IDPROP_INTENSITYLUT_PAGE				= hex2dec('00380520');%	/* R/W, long,	"INTENSITY LUT PAGE"	*/
        DCAM_IDPROP_INTENSITYLUT_WHITECLIP			= hex2dec('00380530');%	/* R/W, long,	"INTENSITY LUT WHITE CLIP"	*/
        DCAM_IDPROP_INTENSITYLUT_BLACKCLIP			= hex2dec('00380540');%	/* R/W, long,	"INTENSITY LUT BLACK CLIP"	*/
        DCAM_IDPROP_SENSORGAPCORRECT_MODE			= hex2dec('00380620');%	/* R/W,	long,	"SENSOR GAP CORRECT MODE"	*/

        % 	/* TAP CALIBRATION */
        DCAM_IDPROP_TAPGAINCALIB_METHOD				= hex2dec('00380F10');%	/* R/W, mode,	"TAP GAIN CALIB METHOD"	*/
        DCAM_IDPROP_TAPCALIB_BASEDATAMEMORY			= hex2dec('00380F20');%	/* R/W, mode,	"TAP CALIB BASE DATA MEMORY"*/
        DCAM_IDPROP_STORETAPCALIBDATATOMEMORY		= hex2dec('00380F30');%	/* W/O, mode,	"STORE TAP CALIB DATA TO MEMORY"*/
        DCAM_IDPROP_TAPCALIBDATAMEMORY				= hex2dec('00380F40');%	/* W/O, mode,	"TAP CALIB DATA MEMORY"	*/
        DCAM_IDPROP_NUMBEROF_TAPCALIB				= hex2dec('00380FF0');%	/* R/W, long,	"NUMBER OF TAP CALIB"	*/
        DCAM_IDPROP_TAPCALIB_GAIN					= hex2dec('00381000');%	/* R/W, mode,	"TAP CALIB GAIN"		*/
        DCAM_IDPROP__TAPCALIB						= hex2dec('00000010');%	/* the offset of ID for Nth TAPCALIB	*/

        % /* Group: READOUT */
        % 	/* readout speed */
        DCAM_IDPROP_READOUTSPEED					= hex2dec('00400110');%	/* R/W, long,	"READOUT SPEED" 		*/
        % 											/*	  0x00400120 is reserved */
        DCAM_IDPROP_READOUT_DIRECTION				= hex2dec('00400130');%	/* R/W, mode,	"READOUT DIRECTION"		*/
        DCAM_IDPROP_READOUT_UNIT					= hex2dec('00400140');%	/* R/O, mode,	"READOUT UNIT"			*/

        % 	/* sensor mode */
        DCAM_IDPROP_SENSORMODE						= hex2dec('00400210');%	/* R/W, mode,	"SENSOR MODE"			*/
        DCAM_IDPROP_SENSORMODE_SLITHEIGHT			= hex2dec('00400220');%	/* R/W, long,	"SENSOR MODE SLIT HEIGHT"		*/	/* reserved */
        DCAM_IDPROP_SENSORMODE_LINEBUNDLEHEIGHT		= hex2dec('00400250');%	/* R/W, long,	"SENSOR MODE LINE BUNDLEHEIGHT"	*/
        DCAM_IDPROP_SENSORMODE_FRAMINGHEIGHT		= hex2dec('00400260');%	/* R/W, long,	"SENSOR MODE FRAMING HEIGHT"	*/	/* reserved */
        DCAM_IDPROP_SENSORMODE_PANORAMICSTARTV		= hex2dec('00400280');%	/* R/W, long,	"SENSOR MODE PANORAMIC START V"	*/

        % 	/* other readout mode */
        DCAM_IDPROP_CCDMODE							= hex2dec('00400310');%	/* R/W, mode,	"CCD MODE"				*/
        DCAM_IDPROP_EMCCD_CALIBRATIONMODE			= hex2dec('00400320');%	/* R/W, mode,	"EM CCD CALIBRATION MODE"	*/
        DCAM_IDPROP_CMOSMODE						= hex2dec('00400350');%	/* R/W, mode,	"CMOS MODE"				*/

        % 	/* output mode */
        DCAM_IDPROP_OUTPUT_INTENSITY				= hex2dec('00400410');%	/* R/W, mode,	"OUTPUT INTENSITY"		*/
        DCAM_IDPROP_OUTPUTDATA_ORIENTATION			= hex2dec('00400420');%	/* R/W, mode,	"OUTPUT DATA ORIENTATION"	*/	/* reserved */
        DCAM_IDPROP_OUTPUTDATA_ROTATION				= hex2dec('00400430');%	/* R/W, degree,	"OUTPUT DATA ROTATION"		*/	/* reserved */
        DCAM_IDPROP_OUTPUTDATA_OPERATION			= hex2dec('00400440');%	/* R/W, mode,	"OUTPUT DATA OPERATION"	*/

        DCAM_IDPROP_TESTPATTERN_KIND				= hex2dec('00400510');%	/* R/W, mode,	"TEST PATTERN KIND"		*/
        DCAM_IDPROP_TESTPATTERN_OPTION				= hex2dec('00400520');%	/* R/W, long,	"TEST PATTERN OPTION"	*/

        DCAM_IDPROP_EXTRACTION_MODE					= hex2dec('00400620');%	/* R/W	mode,	"EXTRACTION MODE	"*/

        % /* Group: ROI */
        % 	/* binning and subarray */
        DCAM_IDPROP_BINNING							= hex2dec('00401110');%	/* R/W, mode,	"BINNING"				*/
        DCAM_IDPROP_BINNING_INDEPENDENT				= hex2dec('00401120');%	/* R/W, mode,	"BINNING INDEPENDENT"	*/
        DCAM_IDPROP_BINNING_HORZ					= hex2dec('00401130');%	/* R/W, long,	"BINNING HORZ"			*/
        DCAM_IDPROP_BINNING_VERT					= hex2dec('00401140');%	/* R/W, long,	"BINNING VERT"			*/
        DCAM_IDPROP_SUBARRAYHPOS					= hex2dec('00402110');%	/* R/W, long,	"SUBARRAY HPOS"			*/
        DCAM_IDPROP_SUBARRAYHSIZE					= hex2dec('00402120');%	/* R/W, long,	"SUBARRAY HSIZE"		*/
        DCAM_IDPROP_SUBARRAYVPOS					= hex2dec('00402130');%	/* R/W, long,	"SUBARRAY VPOS"			*/
        DCAM_IDPROP_SUBARRAYVSIZE					= hex2dec('00402140');%	/* R/W, long,	"SUBARRAY VSIZE"		*/
        DCAM_IDPROP_SUBARRAYMODE					= hex2dec('00402150');%	/* R/W, mode,	"SUBARRAY MODE"			*/
        DCAM_IDPROP_DIGITALBINNING_METHOD			= hex2dec('00402160');%	/* R/W, mode,	"DIGITALBINNING METHOD"	*/
        DCAM_IDPROP_DIGITALBINNING_HORZ				= hex2dec('00402170');%	/* R/W, long,	"DIGITALBINNING HORZ"	*/
        DCAM_IDPROP_DIGITALBINNING_VERT				= hex2dec('00402180');%	/* R/W, long,	"DIGITALBINNING VERT"	*/

        % /* Group: TIMING */
        % 	/* synchronous timing */
        DCAM_IDPROP_TIMING_READOUTTIME				= hex2dec('00403010');%	/* R/O, sec,	"TIMING READOUT TIME"			*/
        DCAM_IDPROP_TIMING_CYCLICTRIGGERPERIOD		= hex2dec('00403020');%	/* R/O, sec,	"TIMING CYCLIC TRIGGER PERIOD"	*/
        DCAM_IDPROP_TIMING_MINTRIGGERBLANKING		= hex2dec('00403030');%	/* R/O, sec,	"TIMING MINIMUM TRIGGER BLANKING"	*/
        % 											/*	  0x00403040 is reserved */
        DCAM_IDPROP_TIMING_MINTRIGGERINTERVAL		= hex2dec('00403050');%	/* R/O, sec,	"TIMING MINIMUM TRIGGER INTERVAL"	*/
        DCAM_IDPROP_TIMING_EXPOSURE					= hex2dec('00403060');%	/* R/O, mode,	"TIMING EXPOSURE"			*/
        DCAM_IDPROP_TIMING_INVALIDEXPOSUREPERIOD	= hex2dec('00403070');%	/* R/O, sec,	"INVALID EXPOSURE PERIOD"	*/
        DCAM_IDPROP_TIMING_FRAMESKIPNUMBER			= hex2dec('00403080');%	/* R/W, long,	"TIMING FRAME SKIP NUMBER"	*/
        DCAM_IDPROP_TIMING_GLOBALEXPOSUREDELAY		= hex2dec('00403090');%	/* R/O, sec,	"TIMING GLOBAL EXPOSURE DELAY"	*/

        DCAM_IDPROP_INTERNALFRAMERATE				= hex2dec('00403810');%	/* R/W, 1/sec,	"INTERNAL FRAME RATE"		*/
        DCAM_IDPROP_INTERNAL_FRAMEINTERVAL			= hex2dec('00403820');%	/* R/W, sec,	"INTERNAL FRAME INTERVAL"	*/
        DCAM_IDPROP_INTERNALLINERATE				= hex2dec('00403830');%	/* R/W, 1/sec,	"INTERNAL LINE RATE"		*/
        DCAM_IDPROP_INTERNALLINESPEED				= hex2dec('00403840');%	/* R/W, m/sec,	"INTERNAL LINE SPEEED"		*/
        DCAM_IDPROP_INTERNAL_LINEINTERVAL			= hex2dec('00403850');%	/* R/W, sec,	"INTERNAL LINE INTERVAL"	*/

        % 	/* system information */

        DCAM_IDPROP_TIMESTAMP_PRODUCER				= hex2dec('00410A10');%	/* R/O, mode,	"TIME STAMP PRODUCER"	*/
        DCAM_IDPROP_FRAMESTAMP_PRODUCER				= hex2dec('00410A20');%	/* R/O, mode,	"FRAME STAMP PRODUCER"	*/

        % /* Group: READOUT */
        % 
        % 	/* image information */
        % 											/*	  0x00420110 is reserved */
        DCAM_IDPROP_COLORTYPE						= hex2dec('00420120');%	/* R/W, mode,	"COLORTYPE"				*/
        DCAM_IDPROP_BITSPERCHANNEL					= hex2dec('00420130');%	/* R/W, long,	"BIT PER CHANNEL"		*/
        % 											/*	  0x00420140 is reserved */
        % 											/*	  0x00420150 is reserved */

        DCAM_IDPROP_NUMBEROF_CHANNEL				= hex2dec('00420180');%	/* R/O, long,	"NUMBER OF CHANNEL"		*/
        DCAM_IDPROP_ACTIVE_CHANNELINDEX				= hex2dec('00420190');%	/* R/W, mode,	"ACTIVE CHANNEL INDEX"	*/
        DCAM_IDPROP_NUMBEROF_VIEW					= hex2dec('004201C0');%	/* R/O, long,	"NUMBER OF VIEW"		*/
        DCAM_IDPROP_ACTIVE_VIEWINDEX				= hex2dec('004201D0');%	/* R/W, mode,	"ACTIVE VIEW INDEX"		*/

        DCAM_IDPROP_IMAGE_WIDTH						= hex2dec('00420210');%	/* R/O, long,	"IMAGE WIDTH"			*/
        DCAM_IDPROP_IMAGE_HEIGHT					= hex2dec('00420220');%	/* R/O, long,	"IMAGE HEIGHT"			*/
        DCAM_IDPROP_IMAGE_ROWBYTES					= hex2dec('00420230');% /* R/O, long,	"IMAGE ROWBYTES"		*/
        DCAM_IDPROP_IMAGE_FRAMEBYTES				= hex2dec('00420240');%	/* R/O, long,	"IMAGE FRAMEBYTES"		*/
        DCAM_IDPROP_IMAGE_TOPOFFSETBYTES			= hex2dec('00420250');%	/* R/O, long,	"IMAGE TOP OFFSET BYTES"*/		/* reserved */
        DCAM_IDPROP_IMAGE_PIXELTYPE					= hex2dec('00420270');%	/* R/W, DCAM_PIXELTYPE,	"IMAGE PIXEL TYPE"	*/
        DCAM_IDPROP_IMAGE_CAMERASTAMP				= hex2dec('00420300');%	/* R/W, long,	"IMAGE CAMERA STAMP"	*/

        DCAM_IDPROP_BUFFER_ROWBYTES					= hex2dec('00420330');	% R/O, long,	"BUFFER ROWBYTES"		*/
        DCAM_IDPROP_BUFFER_FRAMEBYTES				= hex2dec('00420340');	% R/O, long,	"BUFFER FRAME BYTES"		*/
        DCAM_IDPROP_BUFFER_TOPOFFSETBYTES			= hex2dec('00420350');	% R/O, long,	"BUFFER TOP OFFSET BYTES"	*/
        DCAM_IDPROP_BUFFER_PIXELTYPE				= hex2dec('00420360');	% R/O, DCAM_PIXELTYPE,	"BUFFER PIXEL TYPE"	*/

        DCAM_IDPROP_RECORDFIXEDBYTES_PERFILE		= hex2dec('00420410');	% R/O,	long	"RECORD FIXED BYTES PER FILE"	*/
        DCAM_IDPROP_RECORDFIXEDBYTES_PERSESSION		= hex2dec('00420420');	% R/O,	long	"RECORD FIXED BYTES PER SESSION"*/
        DCAM_IDPROP_RECORDFIXEDBYTES_PERFRAME		= hex2dec('00420430');	% R/O,	long	"RECORD FIXED BYTES PER FRAME"	*/

        DCAM_IDPROP_IMAGEDETECTOR_PIXELWIDTH		= hex2dec('00420810');	%R/O, micro-meter, "IMAGE DETECTOR PIXEL WIDTH"	*/	/* reserved */
        DCAM_IDPROP_IMAGEDETECTOR_PIXELHEIGHT		= hex2dec('00420820');	% R/O, micro-meter, "IMAGE DETECTOR PIXEL HEIGHT"	*/	/* reserved */
        % 
        % 	/* frame bundle */
        DCAM_IDPROP_FRAMEBUNDLE_MODE				= hex2dec('00421010');	% R/W, mode,	"FRAMEBUNDLE MODE"		*/
        DCAM_IDPROP_FRAMEBUNDLE_NUMBER				= hex2dec('00421020');	% R/W, long,	"FRAMEBUNDLE NUMBER"	*/
        DCAM_IDPROP_FRAMEBUNDLE_ROWBYTES			= hex2dec('00421030');	% R/O,	long,	"FRAMEBUNDLE ROWBYTES"	*/
        DCAM_IDPROP_FRAMEBUNDLE_FRAMESTEPBYTES		= hex2dec('00421040');	% R/O, long,	"FRAMEBUNDLE FRAME STEP BYTES"	*/

        % 	/* partial area */
        DCAM_IDPROP_NUMBEROF_PARTIALAREA			= hex2dec('00430010');	% R/W, long,	"NUMBER OF PARTIAL AREA"*/
        DCAM_IDPROP_PARTIALAREA_HPOS				= hex2dec('00431000');	% R/W, long,	"PARTIAL AREA HPOS"		*/
        DCAM_IDPROP_PARTIALAREA_HSIZE				= hex2dec('00432000');	% R/W, long,	"PARTIAL AREA HSIZE"	*/
        DCAM_IDPROP_PARTIALAREA_VPOS				= hex2dec('00433000');	% R/W, long,	"PARTIAL AREA VPOS"		*/
        DCAM_IDPROP_PARTIALAREA_VSIZE				= hex2dec('00434000');	% R/W, long,	"PARTIAL AREA VSIZE"	*/
        DCAM_IDPROP__PARTIALAREA					= hex2dec('00000010');	% the offset of ID for Nth PARTIAL AREA */

        % 	/* multi line */
        DCAM_IDPROP_NUMBEROF_MULTILINE				= hex2dec('0044F010');	% R/W, long,	"NUMBER OF MULTI LINE"	*/
        DCAM_IDPROP_MULTILINE_VPOS					= hex2dec('00450000');	% R/W, long,	"MULTI LINE VPOS"		*/
        DCAM_IDPROP_MULTILINE_VSIZE					= hex2dec('00460000');	% R/W, long,	"MULTI LINE VSIZE"		*/
        % 											/*				 - 0x0046FFFF for 4096 MULTI LINEs			*/		/* reserved */
        DCAM_IDPROP__MULTILINE						= hex2dec('00000010');	% the offset of ID for Nth MULTI LINE */

        % 	/* defect */
        DCAM_IDPROP_DEFECTCORRECT_MODE				= hex2dec('00470010');	% R/W, mode,	"DEFECT CORRECT MODE"	*/
        DCAM_IDPROP_NUMBEROF_DEFECTCORRECT			= hex2dec('00470020');	% R/W, long,	"NUMBER OF DEFECT CORRECT"	*/
        DCAM_IDPROP_HOTPIXELCORRECT_LEVEL			= hex2dec('00470030');	% R/W, mode,	"HOT PIXEL CORRECT LEVEL"	*/
        DCAM_IDPROP_DEFECTCORRECT_HPOS				= hex2dec('00471000');	% R/W, long,	"DEFECT CORRECT HPOS"		*/
        DCAM_IDPROP_DEFECTCORRECT_METHOD			= hex2dec('00473000');	% R/W, mode,	"DEFECT CORRECT METHOD"		*/
        % 											/*				 - 0x0047FFFF for 256 DEFECT */
        DCAM_IDPROP__DEFECTCORRECT					= hex2dec('00000010');	% the offset of ID for Nth DEFECT */
        % 
        % /* Group: PACE CONTROL */
        DCAM_IDPROP_PACECONTROL_MODE				= hex2dec('004A0110');	% R/W, mode,	"PACE CONTROL MODE"		*/
        DCAM_IDPROP_NUMBEROF_PACECONTROL			= hex2dec('004A0120');	% R/W, long,	"NUMBER OF PACE CONTROL"*/
        DCAM_IDPROP_PACECONTROL_COUNT				= hex2dec('004A1000');	% R/W, long,	"PACE CONTROL COUNT"	*/
        DCAM_IDPROP_PACECONTROL_INTERVAL			= hex2dec('004A2000');	% R/W, real,	"PACE CONTROL INTERVAL"	*/
        % 											/*				 - 0x004AFFFF for 256 DEFECT, reserved		*/
        DCAM_IDPROP__PACECONTROL					= hex2dec('00000010');	% the offset of ID for Nth PACECONTROL	*/

        % /* Group: CALIBREGION */
        DCAM_IDPROP_CALIBREGION_MODE				= hex2dec('00402410');	% R/W, mode,	"CALIBRATE REGION MODE"		*/
        DCAM_IDPROP_NUMBEROF_CALIBREGION			= hex2dec('00402420');	% R/W, long,	"NUMBER OF CALIBRATE REGION"*/
        DCAM_IDPROP_CALIBREGION_HPOS				= hex2dec('004B0000');	% R/W, long,	"CALIBRATE REGION HPOS"		*/
        DCAM_IDPROP_CALIBREGION_HSIZE				= hex2dec('004B1000');	% R/W, long,	"CALIBRATE REGION HSIZE"	*/
        % 											/*				 - 0x0048FFFF for 256 REGIONs at least		*/
        DCAM_IDPROP__CALIBREGION					= hex2dec('00000010');	% the offset of ID for Nth REGION		*/

        % /* Group: MASKREGION */
        DCAM_IDPROP_MASKREGION_MODE					= hex2dec('00402510');	% R/W, mode,	"MASK REGION MODE"		*/
        DCAM_IDPROP_NUMBEROF_MASKREGION				= hex2dec('00402520');	% R/W, long,	"NUMBER OF MASK REGION"	*/
        DCAM_IDPROP_MASKREGION_HPOS					= hex2dec('004C0000');	% R/W, long,	"MASK REGION HPOS"		*/
        DCAM_IDPROP_MASKREGION_HSIZE				= hex2dec('004C1000');	% R/W, long,	"MASK REGION HSIZE"		*/
        % 											/*				 - 0x0048FFFF for 256 REGIONs at least		*/
        DCAM_IDPROP__MASKREGION						= hex2dec('00000010');	% the offset of ID for Nth REGION		*/

        % /* Group: Camera Status */
        DCAM_IDPROP_CAMERASTATUS_INTENSITY			= hex2dec('004D1110');	% R/O, mode,	"CAMERASTATUS INTENSITY"	*/
        DCAM_IDPROP_CAMERASTATUS_INPUTTRIGGER		= hex2dec('004D1120');	% R/O, mode,	"CAMERASTATUS INPUT TRIGGER"*/
        DCAM_IDPROP_CAMERASTATUS_CALIBRATION		= hex2dec('004D1130');	% R/O, mode,	"CAMERASTATUS CALIBRATION"	*/

        % /* Group: Back Focus Position */
        DCAM_IDPROP_BACKFOCUSPOS_TARGET				= hex2dec('00804010');	% R/W, micro-meter,"BACK FOCUS POSITION TARGET"	*/
        DCAM_IDPROP_BACKFOCUSPOS_CURRENT			= hex2dec('00804020');	% R/O, micro-meter,"BACK FOCUS POSITION CURRENT"	*/
        DCAM_IDPROP_BACKFOCUSPOS_LOADFROMMEMORY		= hex2dec('00804050');	% R/W, long, "BACK FOCUS POSITION LOAD FROM MEMORY"*/
        DCAM_IDPROP_BACKFOCUSPOS_STORETOMEMORY		= hex2dec('00804060');

        % /* Group: SYSTEM */
        % 	/* system property */

        DCAM_IDPROP_SYSTEM_ALIVE					= hex2dec('00FF0010');

        DCAM_IDPROP_CONVERSIONFACTOR_COEFF			= hex2dec('00FFE010');
        DCAM_IDPROP_CONVERSIONFACTOR_OFFSET			= hex2dec('00FFE020');

        % 	/*-- options --*/
        % 
        % 	/* option */
        DCAM_IDPROP__RATIO				= hex2dec('80000000');
        % 	DCAM_IDPROP_EXPOSURETIME_RATIO	= DCAM_IDPROP__RATIO | DCAM_IDPROP_EXPOSURETIME;
        % % 													/* R/W, real,	"EXPOSURE TIME RATIO"	*/				/* reserved */
        % 	DCAM_IDPROP_CONTRASTGAIN_RATIO	= DCAM_IDPROP__RATIO | DCAM_IDPROP_CONTRASTGAIN;
        % % 													/* R/W, real,	"CONTRAST GAIN RATIO"	*/				/* reserved */

        DCAM_IDPROP__CHANNEL			= hex2dec('00000001');
        DCAM_IDPROP__VIEW				= hex2dec('01000000');

        DCAM_IDPROP__MASK_CHANNEL		= hex2dec('0000000F');
        DCAM_IDPROP__MASK_VIEW			= hex2dec('0F000000');
        DCAM_IDPROP__MASK_BODY			= hex2dec('00FFFFF0');

        % % 	/* for backward compativilities */
        % 	DCAMPROP_ATTR_REMOTE_VALUE		= DCAMPROP_ATTR_VOLATILE;
        % 
        % % 	DCAMPROP_PHOTONIMAGING_MODE__0	= DCAMPROP_PHOTONIMAGINGMODE__0;
        % % 	DCAMPROP_PHOTONIMAGING_MODE__1	= DCAMPROP_PHOTONIMAGINGMODE__1;
        % % 	DCAMPROP_PHOTONIMAGING_MODE__2	= DCAMPROP_PHOTONIMAGINGMODE__2;
        % 
        % 	DCAM_IDPROP_SCAN_MODE			= DCAM_IDPROP_SENSORMODE;
        % 	DCAM_IDPROP_SLITSCAN_HEIGHT		= DCAM_IDPROP_SENSORMODE_SLITHEIGHT;
        % 
        % 	DCAM_IDPROP_FRAME_BUNDLEMODE	= DCAM_IDPROP_FRAMEBUNDLE_MODE;
        % 	DCAM_IDPROP_FRAME_BUNDLENUMBER	= DCAM_IDPROP_FRAMEBUNDLE_NUMBER;
        % 	DCAM_IDPROP_FRAME_BUNDLEROWBYTES= DCAM_IDPROP_FRAMEBUNDLE_ROWBYTES;
        % 
        % 	DCAM_IDPROP_ACTIVE_VIEW			= DCAM_IDPROP_ACTIVE_VIEWINDEX;
        % 	DCAM_IDPROP_ACTIVE_VIEWINDEXES	= DCAM_IDPROP_ACTIVE_VIEWINDEX;
        % 	DCAM_IDPROP_SYNCMULTIVIEWREADOUT= DCAM_IDPROP_SYNC_MULTIVIEWEXPOSURE;
        % % /*	DCAM_IDPROP_SYNC_FRAMEREADOUTTIME=DCAM_IDPROP_TIMING_READOUTTIME,				*/	/* reserved */
        % % /*	DCAM_IDPROP_SYNC_CYCLICTRIGGERPERIOD = DCAM_IDPROP_TIMING_CYCLICTRIGGERPERIOD,	*/	/* reserved */
        % 	DCAM_IDPROP_SYNC_MINTRIGGERBLANKING	= DCAM_IDPROP_TIMING_MINTRIGGERBLANKING;
        % 	DCAM_IDPROP_SYNC_FRAMEINTERVAL	= DCAM_IDPROP_INTERNAL_FRAMEINTERVAL;
        % 	DCAM_IDPROP_LOWLIGHTSENSITIVITY	= DCAM_IDPROP_PHOTONIMAGINGMODE;
        % 
        % 	DCAM_IDPROP_DARKCALIB_MAXIMUMINTENSITY	= DCAM_IDPROP_DARKCALIB_STABLEMAXINTENSITY;
        % 	DCAM_IDPROP_SUBTRACT_SAMPLINGCOUNT		= DCAM_IDPROP_DARKCALIB_SAMPLES;
        % 
        % 	DCAM_IDPROP_SHADINGCALIB_MINIMUMINTENSITY					= DCAM_IDPROP_SHADINGCALIB_STABLEMININTENSITY;
        % 	DCAM_IDPROP_SHADINGCALIB_STABLEFRAMECOUNT					= DCAM_IDPROP_SHADINGCALIB_STABLESAMPLES;
        % 	DCAM_IDPROP_SHADINGCALIB_INTENSITYMAXIMUMERRORPERCENTAGE	= DCAM_IDPROP_SHADINGCALIB_STABLEMAXERRORPERCENT;
        % 	DCAM_IDPROP_SHADINGCALIB_AVERAGEFRAMECOUNT					= DCAM_IDPROP_SHADINGCALIB_SAMPLES;
        % 
        DCAMDEV_CAPDOMAIN__DCAMDATA				= 1;
        DCAMDEV_CAPDOMAIN__FRAMEOPTION			= 2;

        DCAMDEV_CAPDOMAIN__FUNCTION				= 0;
        
	DCAM_PIXELTYPE_MONO8		= hex2dec('00000001');
	DCAM_PIXELTYPE_MONO16		= hex2dec('00000002');
	DCAM_PIXELTYPE_MONO12		= hex2dec('00000003');

	DCAM_PIXELTYPE_RGB24		= hex2dec('00000021');
	DCAM_PIXELTYPE_RGB48		= hex2dec('00000022');
	DCAM_PIXELTYPE_BGR24		= hex2dec('00000029');
	DCAM_PIXELTYPE_BGR48		= hex2dec('0000002a');

	DCAM_PIXELTYPE_NONE			= hex2dec('00000000');
    
    	DCAMERR_BUSY				= hex2dec('80000101');  %,/*		API cannot process in busy state.		*/
	DCAMERR_NOTREADY			= hex2dec('80000103');  %,/*		API requires ready state.				*/
	DCAMERR_NOTSTABLE			= hex2dec('80000104');  %,/*		API requires stable or unstable state.	*/
	DCAMERR_UNSTABLE			= hex2dec('80000105');  %,/*		API does not support in unstable state.	*/
	DCAMERR_NOTBUSY				= hex2dec('80000107');  %,/*		API requires busy state.				*/

	DCAMERR_EXCLUDED			= hex2dec('80000110');  %,/*		some resource is exclusive and already used	*/

	DCAMERR_COOLINGTROUBLE		= hex2dec('80000302');  %,/*		something happens near cooler */
	DCAMERR_NOTRIGGER			= hex2dec('80000303');  %,/*		no trigger when necessary. Some camera supports this error. */
	DCAMERR_TEMPERATURE_TROUBLE = hex2dec('80000304');  %,/*		camera warns its temperature */
	DCAMERR_TOOFREQUENTTRIGGER	= hex2dec('80000305');  %,/*		input too frequent trigger. Some camera supports this error. */

 % /* wait error */
	DCAMERR_ABORT				= hex2dec('80000102');  %,/*		abort process			*/
	DCAMERR_TIMEOUT				= hex2dec('80000106');  %,/*		timeout					*/
	DCAMERR_LOSTFRAME			= hex2dec('80000301');  %,/*		frame data is lost		*/
	DCAMERR_MISSINGFRAME_TROUBLE= hex2dec('80000f06');  %,/*		frame is lost but reason is low lever driver's bug */
	DCAMERR_INVALIDIMAGE		= hex2dec('80000321');  %,/*		hpk format data is invalid data	*/

%  /* initialization error */
	DCAMERR_NORESOURCE			= hex2dec('80000201');  %,/*		not enough resource except memory	*/
	DCAMERR_NOMEMORY			= hex2dec('80000203');  %,/*		not enough memory		*/
	DCAMERR_NOMODULE			= hex2dec('80000204');  %,/*		no sub module			*/
	DCAMERR_NODRIVER			= hex2dec('80000205');  %,/*		no driver				*/
	DCAMERR_NOCAMERA			= hex2dec('80000206');  %,/*		no camera				*/
	DCAMERR_NOGRABBER			= hex2dec('80000207');  %,/*		no grabber				*/
	DCAMERR_NOCOMBINATION		= hex2dec('80000208');  %,/*		no combination on registry */

	DCAMERR_FAILOPEN			= hex2dec('80001001');  %,/* DEPRECATED */
	DCAMERR_INVALIDMODULE		= hex2dec('80000211');  %,/*		dcam_init() found invalid module */
	DCAMERR_INVALIDCOMMPORT		= hex2dec('80000212');  %,/*		invalid serial port		*/
	DCAMERR_FAILOPENBUS			= hex2dec('81001001');  %,/*		the bus or driver are not available	*/
	DCAMERR_FAILOPENCAMERA		= hex2dec('82001001');  %,/*		 camera report error during opening	*/

%  /* calling error */
	DCAMERR_INVALIDCAMERA		= hex2dec('80000806');  %,/*		invalid camera		 */
	DCAMERR_INVALIDHANDLE		= hex2dec('80000807');  %,/*		invalid camera handle	*/
	DCAMERR_INVALIDPARAM		= hex2dec('80000808');  %,/*		invalid parameter		*/
	DCAMERR_INVALIDVALUE		= hex2dec('80000821');  %,/*		invalid property value	*/
	DCAMERR_OUTOFRANGE			= hex2dec('80000822');  %,/*		value is out of range	*/
	DCAMERR_NOTWRITABLE			= hex2dec('80000823');  %,/*		the property is not writable	*/
	DCAMERR_NOTREADABLE			= hex2dec('80000824');  %,/*		the property is not readable	*/
	DCAMERR_INVALIDPROPERTYID	= hex2dec('80000825');  %,/*		the property id is invalid	*/
	DCAMERR_NEWAPIREQUIRED		= hex2dec('80000826');  %,/*		old API cannot present the value because only new API need to be used */
	DCAMERR_WRONGHANDSHAKE		= hex2dec('80000827');  %,/*		this error happens DCAM get error code from camera unexpectedly */
	DCAMERR_NOPROPERTY			= hex2dec('80000828');  %,/*		there is no altenative or influence id, or no more property id */
	DCAMERR_INVALIDCHANNEL		= hex2dec('80000829');  %,/*		the property id specifies channel but channel is invalid */
	DCAMERR_INVALIDVIEW			= hex2dec('8000082a');  %,/*		the property id specifies channel but channel is invalid */
	DCAMERR_INVALIDSUBARRAY		= hex2dec('8000082b');  %,/*		the combination of subarray values are invalid. e.g. DCAM_IDPROP_SUBARRAYHPOS + DCAM_IDPROP_SUBARRAYHSIZE is greater than the number of horizontal pixel of sensor. */
	DCAMERR_ACCESSDENY			= hex2dec('8000082c');  %,/*		the property cannot access during this DCAM STATUS */
	DCAMERR_NOVALUETEXT			= hex2dec('8000082d');  %,/*		the property does not have value text */
	DCAMERR_WRONGPROPERTYVALUE	= hex2dec('8000082e');  %,/*		at least one property value is wrong */
	DCAMERR_DISHARMONY			= hex2dec('80000830');  %,/*		the paired camera does not have same parameter */
	DCAMERR_FRAMEBUNDLESHOULDBEOFF=hex2dec('80000832');  %,/*	framebundle mode should be OFF under current property settings */
	DCAMERR_INVALIDFRAMEINDEX	= hex2dec('80000833');  %,/*		the frame index is invalid  */
	DCAMERR_INVALIDSESSIONINDEX	= hex2dec('80000834');  %,/*		the session index is invalid */
	DCAMERR_NOCORRECTIONDATA	= hex2dec('80000838');  %,/*		not take the dark and shading correction data yet.*/
	DCAMERR_CHANNELDEPENDENTVALUE= hex2dec('80000839');  %,/*	each channel has own property value so can't return overall property value. */
	DCAMERR_VIEWDEPENDENTVALUE	= hex2dec('8000083a');  %,/*		each view has own property value so can't return overall property value. */
	DCAMERR_NOTSUPPORT			= hex2dec('80000f03');  %,/*		camera does not support the function or property with current settings */

%  /* camera or bus trouble */
	DCAMERR_FAILREADCAMERA		= hex2dec('83001002');  %,/*		failed to read data from camera	*/
	DCAMERR_FAILWRITECAMERA		= hex2dec('83001003');  %,/*		failed to write data to the camera */
	DCAMERR_CONFLICTCOMMPORT	= hex2dec('83001004');  %,/*		conflict the com port name user set	*/
	DCAMERR_OPTICS_UNPLUGGED	= hex2dec('83001005');  %,/* 	Optics part is unplugged so please check it. */
	DCAMERR_FAILCALIBRATION		= hex2dec('83001006');  %,/*		fail calibration	*/

%	/* 0x84000100 - 0x840001FF, DCAMERR_INVALIDMEMBER_x */
	DCAMERR_INVALIDMEMBER_3		= hex2dec('84000103');  %,/*		3th member variable is invalid value*/
	DCAMERR_INVALIDMEMBER_5		= hex2dec('84000105');  %,/*		5th member variable is invalid value*/
	DCAMERR_INVALIDMEMBER_7		= hex2dec('84000107');  %,/*		7th member variable is invalid value*/
	DCAMERR_INVALIDMEMBER_8		= hex2dec('84000108');  %,/*		7th member variable is invalid value*/
	DCAMERR_INVALIDMEMBER_9		= hex2dec('84000109');  %,/*		9th member variable is invalid value*/
	DCAMERR_FAILEDOPENRECFILE	= hex2dec('84001001');  %,/*		DCAMREC failed to open the file	*/
	DCAMERR_INVALIDRECHANDLE	= hex2dec('84001002');  %,/*		DCAMREC is invalid handle */
	DCAMERR_FAILEDWRITEDATA		= hex2dec('84001003');  %,/*		DCAMREC failed to write the data	*/
	DCAMERR_FAILEDREADDATA		= hex2dec('84001004');  %,/*		DCAMREC failed to read the data	*/
	DCAMERR_NOWRECORDING		= hex2dec('84001005');  %,/*		DCAMREC is recording data now	*/
	DCAMERR_WRITEFULL			= hex2dec('84001006');  %,/*		DCAMREC writes full frame of the session	*/
	DCAMERR_ALREADYOCCUPIED		= hex2dec('84001007');  %,/*		DCAMREC handle is already occupied by other HDCAM	*/
	DCAMERR_TOOLARGEUSERDATASIZE= hex2dec('84001008');  %,/*		DCAMREC is set the large value to user data size	*/
	DCAMERR_INVALIDWAITHANDLE	= hex2dec('84002001');  %,/*		DCAMWAIT is invalid handle	*/
	DCAMERR_NEWRUNTIMEREQUIRED	= hex2dec('84002002');  %,/*		DCAM Module Version is older than the version that the camera requests	*/
	DCAMERR_VERSIONMISMATCH		= hex2dec('84002003');  %,/*		Camre returns the error on setting parameter to limit version	*/
	DCAMERR_RUNAS_FACTORYMODE	= hex2dec('84002004');  %,/*		Camera is running as a factory mode */
	DCAMERR_IMAGE_UNKNOWNSIGNATURE	= hex2dec('84003001');  %,/*	sigunature of image header is unknown or corrupted	*/
	DCAMERR_IMAGE_NEWRUNTIMEREQUIRED= hex2dec('84003002');  %,/* version of image header is newer than version that used DCAM supports	*/
	DCAMERR_IMAGE_ERRORSTATUSEXIST	= hex2dec('84003003');  %,/*	image header stands error status	*/
	DCAMERR_IMAGE_HEADERCORRUPTED	= hex2dec('84004004');  %,/*	image header value is strange	*/
	DCAMERR_IMAGE_BROKENCONTENT		= hex2dec('84004005');  %,/*	image content is corrupted	*/

%  /* calling error for DCAM-API 2.1.3 */
	DCAMERR_UNKNOWNMSGID		= hex2dec('80000801');  %,/*		unknown message id		*/
	DCAMERR_UNKNOWNSTRID		= hex2dec('80000802');  %,/*		unknown string id		*/
	DCAMERR_UNKNOWNPARAMID		= hex2dec('80000803');  %,/*		unkown parameter id		*/
	DCAMERR_UNKNOWNBITSTYPE		= hex2dec('80000804');  %,/*		unknown bitmap bits type			*/
	DCAMERR_UNKNOWNDATATYPE		= hex2dec('80000805');  %,/*		unknown frame data type				*/

 % /* internal error */
	DCAMERR_NONE				= 0; %,		/*		no error, nothing to have done		*/
	DCAMERR_INSTALLATIONINPROGRESS=hex2dec('80000f00');  %,/*	installation progress				*/
	DCAMERR_UNREACH				= hex2dec('80000f01');  %,/*		internal error						*/
	DCAMERR_UNLOADED			= hex2dec('80000f04');  %,/*		calling after process terminated	*/
	DCAMERR_THRUADAPTER			= hex2dec('80000f05');  %,/*											*/
	DCAMERR_NOCONNECTION		= hex2dec('80000f07');  %,/*		HDCAM lost connection to camera		*/

	DCAMERR_NOTIMPLEMENT		= hex2dec('80000f02');  %,/*		not yet implementation				*/

	DCAMERR_APIINIT_INITOPTIONBYTES	= hex2dec('a4010003');  %,/*	"API_INIT has a invalid parameter is initoptionbytes!"	*/
	DCAMERR_APIINIT_INITOPTION		= hex2dec('a4010004');  %,/*	"API_INIT has a invalid parameter is initoption!"	*/

	DCAMERR_INITOPTION_COLLISION_BASE=hex2dec('a401C000');  %,
	DCAMERR_INITOPTION_COLLISION_MAX= hex2dec('a401FFFF');  %,

% 	/*	Between DCAMERR_INITOPTION_COLLISION_BASE and DCAMERR_INITOPTION_COLLISION_MAX means there is collision with initoption in DCAMAPI_INIT. */
% 	/*	The value "(error code) - DCAMERR_INITOPTION_COLLISION_BASE" indicates the index which second INITOPTION group happens. */
% 
% /* success */
	DCAMERR_SUCCESS				= 1; %			/*		no error, general success code, app should check the value is positive	*/

    DCAMBUF_ATTACHKIND_TIMESTAMP	= 1;
	DCAMBUF_ATTACHKIND_FRAMESTAMP	= 2;

	DCAMBUF_ATTACHKIND_PRIMARY_TIMESTAMP	= 3;
	DCAMBUF_ATTACHKIND_PRIMARY_FRAMESTAMP	= 4;

	DCAMBUF_ATTACHKIND_FRAME		= 0;
    
    end      
end