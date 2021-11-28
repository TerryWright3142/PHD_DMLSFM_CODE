% typedef struct R_DCAMDEV_CAPABILITY_ {
% 	int32		size;		// size of whole structure
% 	int32		domain;		// Specify domain
% 	int32		capflag;		// supported flag
% 	int32		kind;		// detail of domain
% } R_DCAMDEV_CAPABILITY;

classdef C_DCAMDEV_CAPABILITY_ < C_BASIC_TYPES
    properties    
      domain;
      capflag; 
      kind;
    end
    methods 
        function obj = C_DCAMDEV_CAPABILITY_(domain, capflag, kind)
                obj.size = 16;  % [in] sizeof(DCAMDEV_CAPABILITY) % check this 
                obj.domain = domain; %[in]
                obj.capflag = capflag; %[out]
                obj.kind = kind; %[in]
                
                pstruct.size = obj.size;
                pstruct.domain = obj.domain;
                pstruct.capflag = obj.capflag;
                pstruct.kind = obj.kind;
                obj.matlabPtr = libpointer('R_DCAMDEV_CAPABILITY_', pstruct);                
        end
        function Refresh(obj)
            obj.capflag = obj.GetPtr().Value.capflag;
        end
    end
end