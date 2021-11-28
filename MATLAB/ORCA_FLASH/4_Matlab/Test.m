classdef Test<handle
    properties
       x 
        
    end
    methods
        function obj=Test()
            
        end
        function SetX(obj)
            obj.x = 5;
        end
        function ReleaseX(obj)
            clear obj.x; % does not work
        end
            
        
        
    end
    
    
    
    
end