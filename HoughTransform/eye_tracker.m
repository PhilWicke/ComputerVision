function [varargout] = eye_tracker(url, varargin)
%EYE_TRACKER(url, varargin)
%   The eye tracker consists of two parts. First you will initialise the
%   scan of the eye field. Secondly you will be able to track they eyes in
%   the eye-field.
%   
%   [EST_RAD, EST_TRE] = EYE_TRACKER(URL,'setup')
%                        This will initialise the eye tracker and asks you
%                        to place your eyes in the provided area. The URL
%                        is the path for the imread(...) command and can be
%                        exchanged by a webcam snapshot. In return you
%                        receive a radius that is the radius which most
%                        often lead to a detection of 2 circles in the eye
%                        field. The threshold is the corresponding
%                        threshold that identified the circles.
%
%   [                ] = EYE_TRACKER(URL,'track',[EST_RAD],[EST_TRE])
%                        This will track the eyes in the provided eye field
%                        according to the previously estimated parameters.
%                        If they have not been estimated before you can
%                        neglect the argument and a standart radius of 10
%                        and a threshold of 5 will be used.
    
    % prepare use of picture loop
    global KEY_IS_PRESSED 
    KEY_IS_PRESSED = 0; 
    fig = figure; 
    set(gcf, 'KeyPressFcn', @myKeyPressFcn);
    
    switch varargin{1}
        
        % align the eyes in region
        case 'setup'
            % We will store five images
            image = rgb2gray(imread(url));  
            img_h = size(image,1);
            img_b = size(image,2);
            images = zeros(5,img_h,img_b);
            IDX = 1;
            
            % and define a region of interest
            roi_lt_dwn = [img_h/4 , 2*(img_b/8)];
            roi_rg_up  = [img_h-(img_h/2),img_b-2*(img_b/8)];
            
            % IN CAMERA LOOP UNTIL KEY IS PRESSED:
            while ~KEY_IS_PRESSED
                if IDX == 5
                    IDX = 1;
                end
                % get current snapshot and display region of interest
                image = rgb2gray(imread(url));              
                image = mark_rec(image,roi_lt_dwn,roi_rg_up);
                imshow(image);
                
                % store the last 5 images
                images(IDX,:,:) = image;
                pause(0.01);
            end
            % take the last 5 images and approximate the eye size
            best_r = zeros(5,1);
            best_t = zeros(5,1);
            
            % Check all 5 images (mark is set to check if 2 circles can be
            % found in any of the images
            mark = 0;
            for idx = 1:5;
                img = reshape(images(idx,:,:),[img_h,img_b]);
                roi = cutting(img,roi_lt_dwn,roi_rg_up);
                
                % Check for different iris diameters and thresholds
                for radius = 2:2:10
                    for threshold = 0:2:10

                        [circY,circX] = my_circHough(roi,radius,threshold);
                        % Only save setting which identified 2 circles 
                        if size(circX,1) == 2
                            best_r(idx) = radius;
                            best_t(idx) = threshold;
                            mark = 1;
                            disp('Two circles identified.');
                        end
                    end
                end
            end
            % radius and threshold are uninitialised if we dont find
            % exactly 2 circles, therefore they remain 0 and we neglect
            % we choose our estimate after the modus (most common value) of
            % the radi we did identify and take the corresponding threshold
            if mark
                est_rad = mode(best_r(best_r~=0));
                est_tre = best_t(best_r==est_rad);
                disp('Estimated radius:');
                disp(est_rad);
            else
                error('Unfortunately the algorithm could not detect two circles.');
            end
            
            % give variable output
            varargout{1} = est_rad;
            varargout{2} = est_tre;
            
        % use circular hough transfrom to track eyes
        case 'track'
            % use default radius and threshold if non are provided
            if isempty(varargin{2}) && isempty(varargin{3}) 
                radius      = 10;
                threshold   = 5;
            else
                radius = varargin{2};
                threshold = varargin{3};
            end
            
            % IN CAMERA LOOP UNTIL KEY IS PRESSED:
            while ~KEY_IS_PRESSED
                image = rgb2gray(imread(url)); 
                img_h = size(image,1);
                img_b = size(image,2);

                % cut out region of interest
                roi_lt_dwn = [img_h/4 , 2*(img_b/8)];
                roi_rg_up  = [img_h-(img_h/2),img_b-2*(img_b/8)];
                roi = cutting(image,roi_lt_dwn,roi_rg_up);
                % get circles in roi
                [circY,circX] = my_circHough(roi,radius,threshold);
 
                % do plotting only if you detect two circles
                imshow(roi);
                if size(circX,1) == 2
                    hold on;
                    plot(circY,circX,'r.','MarkerSize',2);
                end
                pause(0.01);
                
                
            end
        otherwise
            error('Variable argument not supported!');
    end
    
    close(fig);
end
