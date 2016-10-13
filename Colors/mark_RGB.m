function [ image_rect ] = mark_RGB( input_image, pos_01, pos_02, varargin )
%RECTANGLE_HEAD marks a region of an image with a white rectangle
%   Inputs:     input_image = an input image, preferably the cameraman image
%               pos_01 = is the position of the first pixel you want the
%               rectangle to start from
%               pos_02 = is the position of the second pixel you want
%               the rectangle to end at
%               color argument = you can choose between
%                                'r' - marks the object with a red
%                                frame
%                                'b' - marks the object with a blue
%                                frame
%                                'g' - marks the object with a green
%                                frame
%   Outputs:    image_rect = the image marked with a region 

    % Exception handling
    if(ndims(pos_01)~=2)||(ndims(pos_02)~= 2)
        error('Input arguments of rectangle position must contain two coordinates');
    end
    if((pos_01(1) == pos_02(1)) || (pos_01(2) == pos_02(2)))
        error('Rectangle needs two different points.');
    end
    if(pos_01(1) > size(input_image,1)) || (pos_01(2) > size(input_image,2)) || (pos_02(1) > size(input_image,1)) || (pos_02(2) > size(input_image,2))
        error('Rectangle not in image.');
    end
    
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
    
    % Mark the corresponding pixels
    pos_max = [max(pos_01(1),pos_02(1)),max(pos_01(2),pos_02(2))];
    pos_min = [min(pos_01(1),pos_02(1)),min(pos_01(2),pos_02(2))];
    
    % Deal with corners and boundaries. I love logical indexing.
    pos_min(pos_min == 0) = 1;
        
    % (minX -> maxX)@minY and (minY -> maxY)@minX
    input_image( pos_min(1):pos_max(1), pos_min(2),color ) = 255;  
    input_image( pos_min(1),pos_min(2): pos_max(2),color ) = 255; 
    input_image( pos_min(1):pos_max(1), pos_min(2),blank ) = 0; 
    input_image( pos_min(1),pos_min(2): pos_max(2),blank ) = 0; 
    
    
    % (maxX -> minX)@maxY and (maxY -> minY)@maxX
    input_image( pos_min(1):pos_max(1), pos_max(2),color ) = 255;
    input_image( pos_max(1),pos_min(2): pos_max(2),color ) = 255;
    input_image( pos_min(1):pos_max(1), pos_max(2),blank ) = 0;
    input_image( pos_max(1),pos_min(2): pos_max(2),blank ) = 0;
    
    % output the altered image
    image_rect = input_image;

end

