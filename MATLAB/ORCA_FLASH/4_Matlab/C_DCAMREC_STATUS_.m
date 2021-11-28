% typedef struct R_DCAMREC_STATUS_ {
% 	int32		size;		// sizeof(*this)
% 	int32		currentsession_index;		// current session index
% 	int32		maxframecount_per_session;		// maximum frame count per session
% 	int32		currentframe_index;		// current frame index
% 	int32		missingframe_count;		// missing frame count
% 	int32		flags;		// DCAMREC_STATUSFLAG
% 	int32		totalframecount;		// total frame count
% 	int32		reserved;		// reserved
% } R_DCAMREC_STATUS;

classdef C_DCAMREC_STATUS_ < C_BASIC_TYPES
    properties    
      currentsession_index;
      maxframecount_per_session;
      currentframe_index;
      missingframe_count;
      flags;
      totalframecount;
      reserved;
    end
    methods 
        function obj = C_DCAMREC_STATUS_(currentsession_index, maxframecount_per_session, currentframe_index, ...
                missingframe_count, flags, totalframecount, reserved)
                obj.size = 32;  % [in] sizeof(DCAMREC_STATUS) 
                obj.currentsession_index = currentsession_index;
                obj.maxframecount_per_session = maxframecount_per_session;
                obj.currentframe_index = currentframe_index;
                obj.missingframe_count = missingframe_count;
                obj.flags = flags;
                obj.totalframecount = totalframecount;
                obj.reserved = reserved;
                
                pstruct.size = obj.size;
                pstruct.currentsession_index = obj.currentsession_index;
                pstruct.maxframecount_per_session = obj.maxframecount_per_session;
                pstruct.currentframe_index = obj.currentframe_index;
                pstruct.missingframe_count = obj.missingframe_count;
                pstruct.flags = obj.flags;
                pstruct.totalframecount = obj.totalframecount;
                pstruct.reserved = obj.reserved;

                obj.matlabPtr = libpointer('R_DCAMREC_STATUS_', pstruct);                
        end
        function Refresh(obj)          
                obj.currentsession_index = obj.GetPtr().Value.currentsession_index;
                obj.maxframecount_per_session = obj.GetPtr().Value.maxframecount_per_session;
                obj.currentframe_index = obj.GetPtr().Value.currentframe_index;
                obj.missingframe_count = obj.GetPtr().Value.missingframe_count;
                obj.flags = obj.GetPtr().Value.flags;
                obj.totalframecount = obj.GetPtr().Value.totalframecount;
                obj.reserved = obj.GetPtr().Value.reserved;
        end
    end
end