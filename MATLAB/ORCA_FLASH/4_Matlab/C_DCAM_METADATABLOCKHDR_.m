% typedef struct R_DCAM_METADATABLOCKHDR_ {
% 	int32		size;		// size of whole structure, not only this
% 	int32		iKind;		// DCAM_METADATAKIND
% 	int32		option;		// value meaning depends on DCAMBUF_METADATAOPTION or DCAMREC_METADATAOPTION
% 	int32		iFrame;		// start frame index
% 	int32		in_count;		// max count of meta data
% 	int32		outcount;		// count of got meta data
% } R_DCAM_METADATABLOCKHDR;
classdef C_DCAM_METADATABLOCKHDR_ < C_BASIC_TYPES
    properties    
      iKind;
      option;
      iFrame;
      in_count;
      outcount;
    end
    methods 
        function obj = C_DCAM_METADATABLOCKHDR_(iKind, option, iFrame, in_count, outcount)
                obj.size = 24;  % [in] sizeof(DCAM_METADATABLOCKHDR) 
                obj.iKind = iKind;
                obj.option = option;
                obj.iFrame = iFrame;
                obj.in_count = in_count;
                obj.outcount = outcount;
                
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.option = obj.option;
                pstruct.iFrame = obj.iFrame;
                pstruct.in_count = obj.in_count;
                pstruct.outcount = obj.outcount;
                obj.matlabPtr = libpointer('R_DCAM_METADATABLOCKHDR_', pstruct);                
        end
        function Refresh(obj)
                obj.iKind= obj.GetPtr().Value.iKind;
                obj.option= obj.GetPtr().Value.option;
                obj.iFrame= obj.GetPtr().Value.iFrame;
                obj.in_count= obj.GetPtr().Value.in_count;
                obj.outcount= obj.GetPtr().Value.outcount;
        end
    end
end