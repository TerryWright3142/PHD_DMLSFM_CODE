classdef C_DCAMAPI_INIT_ < C_BASIC_TYPES
    properties
      iDeviceCount;
      reserved;
      initoptionbytes;
      initoption;
      guid;  
    end
    methods 
        function obj = C_DCAMAPI_INIT_(iDeviceCount, reserved, initoptionbytes, initoption, guid)
                obj.size = 32; % [in] from sizeof(DCAMAPI_INIT)
                obj.iDeviceCount = iDeviceCount; %[in out]
                obj.reserved = reserved; %[in]
                obj.initoptionbytes = initoptionbytes; %[in]
                obj.initoption = initoption; %[in]
                obj.guid = guid; %[in]
                
                pstruct.size = obj.size;
                pstruct.iDeviceCount = obj.iDeviceCount;
                pstruct.reserved = obj.reserved;
                pstruct.initoptionbytes = obj.initoptionbytes;
                pstruct.initoption = obj.initoption.GetPtr();
                pstruct.guid = obj.guid.GetPtr();
                obj.matlabPtr = libpointer('R_DCAMAPI_INIT_',pstruct); 
        end      
        function Refresh(obj)
            obj.iDeviceCount = obj.matlabPtr.Value.iDeviceCount;           
        end
    end
end

