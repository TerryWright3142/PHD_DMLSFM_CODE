classdef (Abstract) Score < handle 
%base class for a Score object.  Takes an image and returns a score which
%will be large if it is very aberrated
    properties       
    end   
    methods (Abstract)
        val = FindScore(obj, image)
    end
end