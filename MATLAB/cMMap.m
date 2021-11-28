classdef cMMap < handle
    properties
        szMapFile;
        mmap;
        %add the variables and objects that need to be stored here
        var1 = 0;
        var2 = 0;
        var3 = 0;
        x = zeros(1,10);
        y = zeros(1,10);       
    end   
    methods
        function obj = cMMap(szMapFile) 
            obj.szMapFile = szMapFile;
        end
        function sz = Size(obj)
            sz = numel(obj.var1) + ...
                numel(obj.var2) +  ...
                numel(obj.var3) +  ...
                numel(obj.x) +  ...
                numel(obj.y);                     
        end
        function CreateMap(obj)
 
            fileID = fopen(obj.szMapFile,'w');
            fwrite(fileID,  1.0*zeros(1,obj.Size()),'double');
            fclose(fileID);
            obj.OpenMap();
        end
        function OpenMap(obj)
            obj.mmap = memmapfile(obj.szMapFile, 'Writable',true, 'Format', 'double');
            obj.ReadMap();
        end
        function WriteMap(obj)
            cnt = 1;
            obj.var1
            obj.mmap.Data(cnt) = obj.var1;
            cnt = cnt + 1;
            obj.mmap.Data(cnt) = obj.var2;
            cnt = cnt + 1;
            obj.mmap.Data(cnt) = obj.var3;
            cnt = cnt + 1;
            obj.mmap.Data(cnt : cnt + numel(obj.x) - 1) = obj.x;
            cnt = cnt + numel(obj.x) - 1;
            obj.mmap.Data(cnt : cnt + numel(obj.y) - 1) = obj.y;
            cnt = cnt + numel(obj.y) - 1;
     
            
        end 
        function ReadMap(obj)
            cnt = 1;
            obj.var1 = obj.mmap.Data(cnt);
            cnt = cnt + 1;
            obj.var2 = obj.mmap.Data(cnt);
            cnt = cnt + 1;
            obj.var3 = obj.mmap.Data(cnt);
            cnt = cnt + 1;
            obj.x = obj.mmap.Data(cnt : cnt + numel(obj.x) - 1);
            cnt = cnt + numel(obj.x) - 1;
            obj.y = obj.mmap.Data(cnt : cnt + numel(obj.y) - 1);
            cnt = cnt + numel(obj.y) - 1;           
            
        end
        
    end   
end