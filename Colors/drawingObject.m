function [ mask ] = drawingObject( input_img, mask, threshold, varargin )
%DRAWINGOBJECT Summary of this function goes here
%   Detailed explanation goes here
        
    % Understand color argument
    if isempty(varargin) || ismember('r',varargin)
        color = 1;
        blank = [2,3];
    elseif ismember('g',varargin)
        color = 2;
        blank = [1,3];
    elseif ismember('b',varargin)
        color = 3;
        blank = [1,2];
    else
        error('Optional argument defines color of frame use r|g|b]')
    end
    
    % Create RGB mask
    mask_rgb    = input_img(:,:,color) - rgb2gray(input_img);
    mask_rgb    = mask_rgb >= threshold;
    
    
    % perform morphological opening and labelling
    se = strel('disk',5); 
    opened_rgb = imopen(mask_rgb,se);
    label_mat = bwlabel(opened_rgb);
    
    % Identify target
    label_num  = max(max(label_mat));
    label_size = 0;
    target_seg = 0;

    % the elements equal to 0 are the background
    for segment = 1:label_num
        temp_size  = sum(sum(label_mat == segment));
        if label_size < temp_size
            % override last highest size
            label_mat(label_mat == segment-1) = 0;
            label_size = temp_size;
            target_seg = segment;
        else
            % eliminate segment as it is not the biggest
            label_mat(label_mat == segment) = 0;
        end
    end

    % Assign binarization to identified target
    label_mat(label_mat == target_seg) = 1;
    
    % find all non-zero entries in mask
    [rows, cols] = find(label_mat);
    % get min and max coordinates to define rectangle
    tmaxX = max(cols);
    tmaxY = max(rows);
    tminY = min(rows);
    tminX = min(cols);

    % identify center point
    centerY = round((tmaxY-tminY)/2)+tminY;
    centerX = round((tmaxX-tminX)/2)+tminX;
    
    mask( centerY, centerX,color ) = 255;   
    mask( centerY+1, centerX,color ) = 255; 
    mask( centerY+1, centerX+1,color ) = 255; 
    mask( centerY-1, centerX,color ) = 255; 
    mask( centerY-1, centerX-1,color ) = 255; 
    mask( centerY+1, centerX-1,color ) = 255; 
    mask( centerY-1, centerX+1,color ) = 255;
    mask( centerY, centerX+1,color ) = 255;
    mask( centerY, centerX-1,color ) = 255; 
 
    mask( centerY, centerX,blank ) = -255;   
    mask( centerY+1, centerX,blank ) = -255; 
    mask( centerY+1, centerX+1,blank ) = -255; 
    mask( centerY-1, centerX,blank ) = -255; 
    mask( centerY-1, centerX-1,blank ) = -255; 
    mask( centerY+1, centerX-1,blank ) = -255; 
    mask( centerY-1, centerX+1,blank ) = -255;
    mask( centerY, centerX+1,blank ) = -255;
    mask( centerY, centerX-1,blank ) = -255; 
    
    
end

