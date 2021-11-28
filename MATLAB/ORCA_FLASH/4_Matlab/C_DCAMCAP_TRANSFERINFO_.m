% typedef struct R_DCAMCAP_TRANSFERINFO_ {
% 	int32		size;		// sizeof(*this)
% 	int32		iKind;		// DCAMCAP_TRANSFERKIND
% 	int32		nNewestFrameIndex;		// index of the newest frame
% 	int32		nFrameCount;		// number of captured frames
% } R_DCAMCAP_TRANSFERINFO;

classdef C_DCAMCAP_TRANSFERINFO_ < C_BASIC_TYPES
    properties    
      iKind;
      nNewestFrameIndex;
      nFrameCount;
    end
    methods 
        function obj = C_DCAMCAP_TRANSFERINFO_(iKind, nNewestFrameIndex, nFrameCount)
                obj.size = 16;  % [in] sizeof(C_DCAMCAP_TRANSFERINFO) 
            if nargin == 0
                obj.iKind = 0; %[in]
                obj.nNewestFrameIndex = 0; %[in out]
                obj.nFrameCount = 0; %[in out]               
            else
                obj.iKind = iKind; %[in]
                obj.nNewestFrameIndex = nNewestFrameIndex; %[in out]
                obj.nFrameCount = nFrameCount; %[in out]
            end
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.nNewestFrameIndex = obj.nNewestFrameIndex;
                pstruct.nFrameCount = obj.nFrameCount;
                obj.matlabPtr = libpointer('R_DCAMCAP_TRANSFERINFO_', pstruct);                
        end
        function Refresh(obj)
            obj.nNewestFrameIndex = obj.matlabPtr.Value.nNewestFrameIndex;
            obj.nFrameCount = obj.matlabPtr.Value.nFrameCount;
        end

    end
end