% typedef struct R_DCAMBUF_ATTACH_ {
% 	int32		size;		// sizeof(*this)
% 	int32		iKind;		// DCAMBUF_ATTACHKIND
% 	void**		buffer;		// array of buffer pointers
% 	int32		buffercount;		// number of pointers in array "buffer"
% } R_DCAMBUF_ATTACH;

classdef C_DCAMBUF_ATTACH_ < C_BASIC_TYPES
    properties    
      iKind;
      buffer;
      buffercount;
    end
    methods
        function obj = C_DCAMBUF_ATTACH_(iKind, buffer, buffercount)
                obj.size = 16;  % [in] sizeof(DCAMBUF_ATTACH) 
                obj.iKind = iKind; %[in out]
                obj.buffer = buffer;
                obj.buffercount = buffercount; % [in]
                
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.buffer = obj.buffer;
                pstruct.buffercount = obj.buffercount;
                obj.matlabPtr = libpointer('R_DCAMBUF_ATTACH_Ptr', pstruct);                
        end
        function Refresh(obj)
                obj.buffer = obj.GetPtr().Value.buffer;

        end
    end
end