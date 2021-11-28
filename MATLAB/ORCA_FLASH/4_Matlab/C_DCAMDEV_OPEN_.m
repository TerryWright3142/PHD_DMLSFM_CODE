%R_DCAMDEV_OPEN_
classdef C_DCAMDEV_OPEN_ < C_BASIC_TYPES
    properties    
      index;
      hdcam;
    end
    methods 
        function obj = C_DCAMDEV_OPEN_(index)
                obj.size = 16;  %[in]  get from c++ sizeof(DCAMDEV_OPEN) 
                obj.index = index; %[in]
                obj.hdcam = 0; %[in out]
                pstruct.size = obj.size;
                pstruct.index = obj.index;
                pstruct.hdcam = obj.hdcam;
                obj.matlabPtr = libpointer('R_DCAMDEV_OPEN_', pstruct);                
        end
        %do we need a refresh function arnt these passed by ref
        function Refresh(obj)
            obj.hdcam = obj.GetPtr().Value.hdcam;          
        end
        function  h = GetHDCAM(obj)
            h = obj.hdcam;
        end
    end
end