% typedef struct R_DCAM_TIMESTAMP_ {
% 	int32		sec;		//
% 	int32		microsec;		//
% } R_DCAM_TIMESTAMP;

classdef C_DCAM_TIMESTAMP_ < C_BASIC_TYPES
    properties    
      sec;
      microsec;
    end
    methods 
        function obj = C_DCAM_TIMESTAMP_(sec, microsec)
                obj.size = 8;  %sizeof(DCAM_TIMESTAMP) 
                if nargin == 0
                    obj.sec = 0;
                    obj.microsec = 0;                  
                else
                    obj.sec = sec; % [in out]
                    obj.microsec = microsec; % [ in out]
                end
                pstruct.sec = obj.sec;
                pstruct.microsec = obj.microsec;
                obj.matlabPtr = libpointer('R_DCAM_TIMESTAMP_', pstruct);                
        end
        function Refresh(obj)  
            obj.sec = obj.GetPtr().Value.sec;
            obj.microsec = obj.GetPtr().Value.microsec;          
        end

    end
end
