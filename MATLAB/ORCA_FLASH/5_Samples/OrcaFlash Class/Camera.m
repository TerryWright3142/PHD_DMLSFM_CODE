classdef (Abstract) Camera < handle 
    properties  
    end
    
    methods (Abstract)
        Init(obj);
        im = CaptureImage(obj);
        im = CaptureBackground(obj, num);
        DrawImage(obj);
        Shutdown(obj);
        Trace(obj);
    end


end