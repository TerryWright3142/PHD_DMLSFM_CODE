% typedef struct R_DCAM_METADATAHDR_ {
% 	int32		size;		// size of whole structure, not only this
% 	int32		iKind;		// DCAM_METADATAKIND (DCAMBUF_METADATAKIND or DCAMREC_METADATAKIND)
% 	int32		option;		// value meaning depends on DCAM_METADATAKIND
% 	int32		iFrame;		// frame index
% } R_DCAM_METADATAHDR;

classdef C_DCAM_METADATAHDR_ < C_BASIC_TYPES
    properties    
            iKind;
            option;
            iFrame;
    end
    methods 
        function obj = C_DCAM_METADATAHDR_(iKind, option, iFrame)
                obj.size = 16;  % [in] sizeof(DCAM_METADATAHDR) 
                obj.iKind = iKind;
                obj.option = option;
                obj.iFrame = iFrame;
                
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.option = obj.option;
                pstruct.iFrame = obj.iFrame;
                
                obj.matlabPtr = libpointer('R_DCAM_METADATAHDR_', pstruct);                
        end
        function Refresh(obj)

                obj.iKind = obj.GetPtr().Value.iKind;
                obj.option = obj.GetPtr().Value.option;
                obj.iFrame = obj.GetPtr().Value.iFrame;
        end
    end
end