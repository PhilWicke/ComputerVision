function [ X,Y,Z ] = hsv2cone( img )
%HSV2CONE = hsv2cone( img ) transforms an hsv image into a HSV space cone
%representation
%   Input:  img     = input image
%   Output: X,Y,Z   = coordinates of the hsv values in cone space

    % Extract Hue, Saturation and Value out of image
    hue = img(:,1);
    hue = (2*pi) *hue;
    saturation = img(:,2);
    value =img(:,3);
    
    % in the cylinder form the coordinates must be transformed by
    % trigonometrical functions: S is defined by the cosine of hue and the
    % hue value defined by its sine.
    for IDX = 1:size(img,1)
        X(IDX) = cos(hue(IDX))*saturation(IDX)*value(IDX);
        Y(IDX) = sin(hue(IDX))*saturation(IDX)*value(IDX);
    end
    
    % Value stays unchanged
    Z = value;
    % Saturation must be scaled by value and shifted towards 0.5
    X = (X'+value)/2+(1-value)*0.5;
    % Hue must be scaled by value and shifted towards 0.5
    Y = (Y'+value)/2+(1-value)*0.5;


end

