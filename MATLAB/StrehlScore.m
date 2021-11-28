classdef  StrehlScore  
    properties
        r
    end    
    methods 
        function obj = StrehlScore(r)
            obj.r = r;
        end
        function [val, mx] = FindScore(obj, image)
            %finds max/sum
            %remove the background light
            image = double(image);
            [X,Y] = meshgrid(1:size(image,2), 1:size(image,1));
            
            x_moment = X.*image;
            x_mean = sum(x_moment(:))/sum(image(:));
            y_moment = Y.*image;
            y_mean = sum(y_moment(:))/sum(image(:));
            R = sqrt( (x_mean - X).^2 + (y_mean - Y).^2 );
            pix = image(R<obj.r);
            val = max(pix(:))/sum(pix(:));     

        end
    end
end