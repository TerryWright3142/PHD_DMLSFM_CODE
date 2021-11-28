classdef  MeanScore < Score 
    %returns the score from the image (background corrected
    properties  
       x
       y
       dx
       dy
       mean_x;
       mean_y;
       im
       background;
       bShowRect;
       bShowScore;
       avBack
    end
    
    methods 
        function obj = MeanScore(x1, y1, dx1, dy1)
            %%define the rectangle to find the centroid
            obj.x = x1;
            obj.y = y1;
            obj.dx = dx1;
            obj.dy = dy1;
            obj.mean_x = 0;
            obj.mean_y = 0;
            obj.bShowRect = false;
            obj.bShowScore = false;
        end
        function SetShowRect(obj, bShowRect)
            obj.bShowRect = bShowRect;
        end
        function SetShowScore(obj, bShowScore)
            obj.bShowScore = bShowScore;
        end
        function SetBackground(obj, background)
            %%check this c++ like syntax
            obj.background = background;
        end
 
        function [val, val1] = FindScore(obj, image)
          %remove the background light
            
            image = double(image); % - double(obj.background);
            [height, width] = size(image);
            y_sub = max(1, round(obj.y - obj.dy/2)) : min(round(obj.y + obj.dy/2), height);
            x_sub = max(1, round(obj.x - obj.dx/2)) : min(round(obj.x + obj.dx/2), width);
            obj.im = image(y_sub, x_sub);
            imagesc(obj.im);
            drawnow;
            %obj.im(obj.im<max(obj.im(:))/4) = 0; %otherwise just choose the centre
            [X,Y] = meshgrid(1:numel(x_sub), 1:numel(y_sub));
            tot = sum(obj.im(:));
            Y_mom = Y.*obj.im;
            obj.mean_y = sum(Y_mom(:))/tot;
            X_mom = X.*obj.im;
            obj.mean_x = sum(X_mom(:))/tot;
            val = obj.im(round(obj.mean_y), round(obj.mean_x));
            
            X1 = X - obj.mean_x;
            Y1 = Y - obj.mean_y;
            R = sqrt( X1.^2 + Y1.^2);
            R_mom = R.*obj.im;
            val1 = mean(R_mom(:));
        end
        function [xm,ym] = GetMean(obj)
            xm = obj.mean_x;
            ym = obj.mean_y;
            
        end
        function DrawImage(obj)
            if size(obj.im, 1)>0
                im1 = obj.im;
                im1(round(obj.mean_y), round(obj.mean_x)) = 0;
                imagesc(im1);         
                drawnow;
             
            end
        end

    end


end