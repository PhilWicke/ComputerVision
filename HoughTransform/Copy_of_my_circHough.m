function [ output_img ] = my_circHough( input_img, radius )
%MY_HOUGH Summary of this function goes here
%   Detailed explanation goes here

    
    if ndims(input_img) ~= 2
        error('Image is not a 2D grayscale image!');
    end
    img = input_img;
    
    % get image sizes
    img_h = size(input_img,1);
    img_l = size(input_img,2);
    
    % dilate image
    str = strel('disk', 2); 
    img = imerode(img, str); 
    
    % get the gradient information
    gradi    = gradient(double(img));
    
    % only observe lines of high gradient
    img = zeros(img_h, img_l);
    img(gradi~=0) = 255;
 
    [X,Y] = find(img);

    r = radius;
    temp = 1;
    
    % find set of intersection of circles ON every point
    % FIX inters = zeros( (size(X,1)-1)*(size(X,1)) , 2);
    for IDXa = 1:size(X,1)-1
        for IDXb = IDXa+1:size(X,1)
            % get the intersection points of two circles
            [xc yc] = circcirc(X(IDXa),Y(IDXa),r,X(IDXb),Y(IDXb),r);
            % built usable format
            form = round([xc' yc']);
            % neglect circles having no overlap (NaN's)
            if(any(isnan(xc)+isnan(yc))); 
                break; 
            % neglect intersections outside the picture
            elseif any(form(1,1)>img_h) || any(form(1,2)>img_l)
                break;
            end;      
            % store first point in inters(ection) matrix
            inters(temp,:) = form(1,:);
            temp = temp+1;
            % only if points differ (two intersecting circles) save it too
            % and check if they are within the picture boundaries
            if any(form(2,1)>img_h) || any(form(2,2)>img_l)
                break;
            elseif(any(form(1,:)~=form(2,:)))
                inters(temp,:) = form(2,:);
                temp = temp+1;
            end
        end
    end
    
    
    % identify intersection points
    canvas = zeros(img_h,img_l);
    
    for IDXval = 1:size(inters,1)
        canvas(inters(IDXval,1),inters(IDXval,2)) = ...
            canvas(inters(IDXval,1),inters(IDXval,2)) + 1;
    end
    
    
    output_img = mat2gray(canvas);
    
end

