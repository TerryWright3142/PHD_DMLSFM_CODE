% typedef struct R_DCAMDATA_HDR_ {
% 	int32		size;		// size of whole structure, not only this
% 	int32		iKind;		//
% 	int32		option;		// DCAMDATA_OPTION
% 	int32		reserved2;		// reserved
% } R_DCAMDATA_HDR;
classdef C_DCAMDATA_HDR_ < C_BASIC_TYPES
   properties    
        iKind
        option
        reserved2
    end
    methods 
        function obj = C_DCAMDATA_HDR_(iKind, option, reserved2)
                obj.size = 16;  % [in] sizeof(C_DCAMDATA_HDR) 
                obj.iKind = iKind; %[in out]
                obj.option = option; % [in]
                obj.reserved2 = reserved2; % [in]
                
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.option = obj.option;
                pstruct.reserved2 = obj.reserved2;
                obj.matlabPtr = libpointer('R_DCAMDATA_HDR_', pstruct);                
        end
        function Refresh(obj)
                obj.iKind = obj.GetPtr().Value.iKind;
                obj.option = obj.GetPtr().Value.option;
                obj.reserved2 = obj.GetPtr().Value.reserved2;
        end
    end
end