classdef  Mode < Score 
    %returns the kurtosis score from the image (background corrected)
    properties  
       x
       y
       dx
       dy
       mode_x;
       mode_y;
       x_mode;
       y_mode;
       im
    end
    
    methods 
        function obj = Mode(x1, y1, dx1, dy1)
            obj.x = x1;
            obj.y = y1;
            obj.dx = dx1;
            obj.dy = dy1;

        end
%         function  [xmode, ymode] = FindMode(obj, image)
%             image = medfilt2(image);  %median fliter
%             subimage = double(image( obj.y:(obj.y + obj.dy), obj.x:(obj.x + obj.dx)));
%             maxValue = max(subimage(:));
%             % Find all locations where it exists.
%             [rowsOfMaxes, colsOfMaxes] = find(subimage == maxValue);
%             obj.mode_y = mean(rowsOfMaxes);
%             obj.mode_x = mean(colsOfMaxes);
%             obj.x_mode = obj.mode_x + obj.x;
%             obj.y_mode = obj.mode_y + obj.y;
%             
% %             subimage(uint32(round(obj.mode_y)), uint32(round(obj.mode_x))) = 0;
% %             imagesc(subimage);
% %             drawnow;
%              % fprintf('%d %d %d %d\n', obj.x, obj.y, obj.dx, obj.dy);
%             
%         end
        function FindScore(obj, image)
            %fprintf('%d %d %d %d\n', obj.x, obj.y, obj.dx, obj.dy);
            image = medfilt2(image);  %median fliter
            subimage = double(image( obj.y:(obj.y + obj.dy), obj.x:(obj.x + obj.dx)));
            maxValue = max(subimage(:));
            % Find all locations where it exists.
            [rowsOfMaxes, colsOfMaxes] = find(subimage == maxValue);
            obj.mode_y = mean(rowsOfMaxes);
            obj.mode_x = mean(colsOfMaxes);
            obj.x_mode = obj.mode_x + obj.x;
            obj.y_mode = obj.mode_y + obj.y;
      
        end

    end


end