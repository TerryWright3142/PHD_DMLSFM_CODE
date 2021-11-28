% typedef struct R_DCAMWAIT_START_ {
% 	int32		size;		// sizeof(*this)
% 	int32		eventhappened;		//
% 	int32		eventmask;		//
% 	int32		timeout;		//
% } R_DCAMWAIT_START;

classdef C_DCAMWAIT_START_ < C_BASIC_TYPES
    properties    
      eventhappened
      eventmask
      timeout
    end
    methods 
        function obj = C_DCAMWAIT_START_(eventhappened, eventmask, timeout)
                obj.size = 16;  % [in] sizeof(DCAMWAIT_START) 
                obj.eventhappened = eventhappened; %[in out]
                obj.eventmask = eventmask; % [in]
                obj.timeout = timeout; % [in]
                
                pstruct.size = obj.size;
                pstruct.eventhappened = obj.eventhappened;
                pstruct.eventmask = obj.eventmask;
                pstruct.timeout = obj.timeout;
                obj.matlabPtr = libpointer('R_DCAMWAIT_START_', pstruct);                
        end
        function Refresh(obj)
            obj.eventhappened = obj.GetPtr().Value.eventhappened;
        end
    end
end