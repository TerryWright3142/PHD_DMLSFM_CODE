% worked fine 31/10
classdef (Abstract) Mirror < handle
    methods (Abstract)
        Init(obj);
        Poke(obj, act, val);
        Flatten(obj);
        SetSurface(obj, mirrorSurface);
        Shutdown(obj);
        DrawMirror(obj);
    end
end