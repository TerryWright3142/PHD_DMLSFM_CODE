classdef C_DCAM_GUID_ < C_BASIC_TYPES
    properties
      Data1;
      Data2;
      Data3;
      Data4;  
    end
    methods 
        function obj = C_DCAM_GUID_(Data1, Data2, Data3, Data4)         
            if nargin == 0
                obj.size = 0;
                obj.matlabPtr = libpointer;
            else
                obj.size = 16; %sizeof(DCAM_GUID)
                obj.Data1 = Data1;
                obj.Data2 = Data2;
                obj.Data3 = Data3;
                obj.Data4 = Data4;
                
                pstruct.Data1 = obj.Data1;
                pstruct.Data2 = obj.Data2;
                pstruct.Data3 = obj.Data3;
                pstruct.Data4 = obj.Data4;
                obj.matlabPtr = libpointer('R_DCAM_GUID_',pstruct); 
            end


        end

       

    end
end
