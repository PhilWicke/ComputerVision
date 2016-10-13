function [ marked_img ] = trackObject( input_img, threshold, varargin)
%TRACKOBJECT( input_img, threshold, varargin)
%   Allows to identify the biggest object of any RGB color in an image
%   given a threshold. You provide the image, the threshold and the color
%   argument and receive the marked object.
%
%   Inputs:     input_img = the image you want to track the object in
%               threshold = this heavily depends on the lightening and
%               brightness of the given image. 30 works well for red
%               objects. Lower values work better for green and blue.
%               color argument = you can choose between
%                                'r' - marks the red object with a red
%                                frame
%                                'b' - marks the blue object with a blue
%                                frame
%                                'g' - marks the green object with a green
%                                frame
    
    % Understand color argument
    if (isempty(varargin) || ismember('r',varargin))
        color = 1;
    elseif ismember('g',varargin)
        color = 2;
    elseif ismember('b',varargin)
        color = 3;
    else
        error('Optional argument defines color of object use r|g|b')
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

    marked_img = mark_RGB(input_img,[tmaxY,tmaxX],[tminY,tminX],...
                 varargin{1});
    % draw thicker boundary:
    marked_img = mark_RGB(marked_img,[tmaxY-1,tmaxX-1],[tminY-1,tminX-1],...    
                 varargin{1});
    
end

