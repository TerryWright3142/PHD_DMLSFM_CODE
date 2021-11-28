classdef C_INT32_ARRAY_ < C_BASIC_TYPES
    properties
      array; 
    end
    methods 
        function obj = C_INT32_ARRAY_(data)
            if nargin ~= 0
                obj.size = obj.INT32__*length(data);
                obj.array = data;
                obj.matlabPtr = libpointer('int32Ptr', int32(obj.array));
            else
                obj.size = 0;
                obj.array = [];
                obj.matlabPtr = libpointer;
            end
        end      
    end
end