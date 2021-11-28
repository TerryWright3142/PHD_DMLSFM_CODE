classdef CPinholeAnalysis < handle
    properties
        lam = 0.550;  %wavelength (microns)
        NA = 0.85; 
        m = 20; %lateral magnification
        %dimensions of the image plane - optical axis (microns)
        x_max = 100;
        y_max = 100;
        %spatial frequency of samples from the image plane (microns)
        dx = 0.1;
        dy = 0.1;
        %pinhole radius
        pinhole_radius = 0.5;
        imagePlane; % normalised intensity of the pinholes imaged through the optical system
        imagePinholes; % normalised intensity image of a pinhole using the image plane dimensions
        imageAiry; % normalised intentsity image of the Airy disk for the imaging system
        pixel_width = 6.5;
        pixel_height = 6.5;
        %sensor displacement from the top left image position
        sensor_delta_x = 20;
        sensor_delta_y = 0;       
        imageSensor; %normalised intensity image of the CCD
        
        X;
        Y;
        eps = 1e-5;
        
        bCoherent = false;
        
    end
    methods
        function obj = CPinholeAnalysis(lam, NA, m, x_max, dx, y_max, dy,  pinhole_radius, bCoherent)
           if nargin > 0
               obj.lam = lam;
               obj.NA = NA;
               obj.m = m;
               obj.x_max = x_max;
               obj.y_max = y_max;
               obj.dx = dx;
               obj.dy = dy;
               obj.pinhole_radius = pinhole_radius; 
               obj.bCoherent = bCoherent;
           end          
        %x_series and y_series are lists of sampling coordinates
        x_series = -obj.x_max:obj.dx:obj.x_max;
        y_series = -obj.y_max:obj.dy:obj.y_max;
        [obj.X,obj.Y] = meshgrid(x_series, y_series);
        r = sqrt(obj.X.^2 + obj.Y.^2) + obj.eps; %1e-5 to prevent divide by 0 errors
% how do I do coh and incoh
        obj.imageAiry = (besselj(1, (2*pi/obj.lam)*obj.NA*r/obj.m)./r).^2;
        tot = sum(obj.imageAiry(:));
        %normalise the imageAiry
        obj.imageAiry = obj.imageAiry/tot;
        FT_Airy = fftshift(fft2(obj.imageAiry));
        obj.imagePinholes = zeros(size(obj.X));
        obj.imagePinholes( sqrt(obj.X.^2 + obj.Y.^2) < obj.pinhole_radius*obj.m) = 1;
        obj.imagePinholes = obj.imagePinholes/sum(obj.imagePinholes(:));
        FT_pinholes = fftshift(fft2(obj.imagePinholes));
        FT_out = FT_Airy.*FT_pinholes;
        obj.imagePlane = abs(fftshift(ifft2(FT_out)));  %% put an offset on
        end
        function IncoherentImage(obj)
            
            
        end
        function CoherentImage(obj)
            
            
        end
        function DrawImagePlane(obj)
            imagesc(obj.imagePlane);
            title(['NA=' num2str( obj.NA) ' m=' num2str(obj.m) ' lambda=' num2str(obj.lam) ' Xmax=' num2str(obj.x_max) ' Ymax=' num2str(obj.y_max) ' dx=' num2str(obj.dx) ' dy=' num2str(obj.dy)]);
        end
        function SetSensor(obj, pixel_width, pixel_height, sensor_delta_x, sensor_delta_y)
            if nargin>0
                obj.pixel_width = pixel_width;
                obj.pixel_height = pixel_height;
                obj.sensor_delta_x = sensor_delta_x;
                obj.sensor_delta_y = sensor_delta_y;
            end
            bin_x0 = -obj.x_max + obj.sensor_delta_x ;
            bin_y0 = -obj.y_max + obj.sensor_delta_y ;
            %pins_quant is the reading from the sensor
            obj.imageSensor = double(zeros( ceil((obj.y_max - bin_y0)/obj.pixel_height)+1, ceil((obj.x_max - bin_x0)/obj.pixel_width)+1));
            for x = 1:numel(-obj.x_max:obj.dx:obj.x_max)
                for y = 1:numel(-obj.y_max:obj.dy:obj.y_max)
                    %iterate through each pixel
                    x_val = obj.X(y,x);
                    y_val = obj.Y(y,x);
                    intensity = abs(obj.imagePlane(y,x));
                    x_i = ceil( ((x_val - bin_x0) + obj.eps)/obj.pixel_width );
                    y_i = ceil( ((y_val - bin_y0) + obj.eps)/obj.pixel_height);
                    if x_i > 0 && y_i > 0
                        obj.imageSensor(y_i, x_i) = obj.imageSensor(y_i, x_i) + intensity;
                    end

                end
            end
            obj.imageSensor = obj.imageSensor/sum(obj.imageSensor(:));
        end
        function DrawSensor(obj)
            imagesc(obj.imageSensor);
            title(['pixel width=' num2str(obj.pixel_width) ' pixel height=' num2str(obj.pixel_height) ' delta x=' num2str(obj.sensor_delta_x) ' delta y=' num2str(obj.sensor_delta_y)]);
        end
        function res = ApplyStatistic(obj, stat)
            res = stat.FindScore(obj.imageSensor);         
        end
        function FindSensorPixellationNoise(obj, stat)
            %iterate through lots of pixel displacements within the size of
            %a pixel and find the scores then plot as a histogram giving
            %the mean and the std
            numTrials = 30;
            results = zeros(1, numTrials);
            for f = 1:numTrials
                obj.SetSensor(obj.pixel_width, obj.pixel_height, rand()*obj.pixel_width, rand()*obj.pixel_height);
                results(f) = obj.ApplyStatistic(stat); 
                disp(num2str(f));
            end
            histogram(results);
            fprintf( 'mean = %d, std dev = %d \n', mean(results), std(results));
            
            
        end
        
        

    
    end
    methods(Static)
        function Test()
            pins = CPinholeAnalysis(0.5, 0.85, 40, 200, 0.1, 200, 0.1, 0.5);
            %pins.DrawImagePlane();
            pins.SetSensor(15,15,3,3);
            pins.DrawSensor();

            fprintf('score = %d \n', res);
            
        end
    end
    
    
    
end