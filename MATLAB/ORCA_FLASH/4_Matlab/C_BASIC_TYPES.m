classdef  C_BASIC_TYPES < handle
    properties    
        size;
        matlabPtr;      
    end
    methods 
        function sz = SizeOf(obj) 
                sz = obj.size;           
        end
        function p = GetPtr(obj)
                p = obj.matlabPtr;
        end          
    end
end