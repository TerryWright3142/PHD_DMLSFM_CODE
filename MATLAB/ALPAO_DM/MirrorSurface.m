classdef (Abstract) MirrorSurface < handle
    %calculates the mirror surface R from parameter list r
    %these could be radial coefficients, xy values as in a 2D Taylor or 
    %Zernike modes etc
    %the Structure also stores the surface

    methods (Abstract)
        SetSurface(obj, r);
        R = GetSurface(obj); 
        DrawSurface(obj);
    end
    
    
    
end