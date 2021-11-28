% typedef struct R_DCAMWAIT_OPEN_ {
% 	int32		size;		// sizeof(*this)
% 	int32		supportevent;		// supported events
% 	R_HDCAMWAIT		hwait;		// handle for dcamwait functions
% 	R_HDCAM		hdcam;		// the HDCAM handle of the device
% } R_DCAMWAIT_OPEN;

classdef C_DCAMWAIT_OPEN_ < C_BASIC_TYPES
    properties    
      supportevent 
      hwait 
      hdcam 
    end
    methods 
        function obj = C_DCAMWAIT_OPEN_(supportevent, hwait, hdcam)
                obj.size = 24;  % [in] sizeof(DCAMWAIT_OPEN) 
                obj.supportevent = supportevent; %[in out]
                obj.hwait = hwait; % [in out]
                obj.hdcam = hdcam; % [in]
                
                pstruct.size = obj.size;
                pstruct.supportevent = obj.supportevent;
                pstruct.hwait = obj.hwait;
                pstruct.hdcam = obj.hdcam;
                obj.matlabPtr = libpointer('R_DCAMWAIT_OPEN_', pstruct);                
        end
        function Refresh(obj)
            obj.hwait = obj.GetPtr().Value.hwait;
            obj.supportevent = obj.GetPtr().Value.supportevent;
        end
        function  h = GetHWAIT(obj)
            h = obj.hwait;
        end
    end
end