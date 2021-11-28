%R_DCAMDEV_STRING_
classdef C_DCAMDEV_STRING_ < C_BASIC_TYPES
    properties  
      iString;
      text;
      textbytes; 
    end
    methods 
        function obj = C_DCAMDEV_STRING_(iString, text)         
                obj.iString = iString; % [in]
                obj.text = text; % [in out]
                obj.textbytes = length(obj.text); % [in]
                obj.size = 24; % [in]  get from sizeof(DCAMDEV_STRING)
                pstruct.size = obj.size;
                pstruct.iString = obj.iString;
                pstruct.textbytes = obj.textbytes;
                pstruct.text = [int8(obj.text) 0];
                obj.matlabPtr = libpointer('R_DCAMDEV_STRING_',pstruct); 
        end
        %do we need a refresh arnt these passed by value
        function Refresh(obj) 
                obj.text = char(obj.GetPtr().Value.text); 
        end

    end
end