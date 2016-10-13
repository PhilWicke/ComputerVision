function [ image_cut ] = cutting( input_image, pos_01, pos_02)
%CUTIING extracts a rectangular region from an image
%   Inputs:     input_image = an input image, preferably the cameraman image
%               pos_01 = is the position of the first pixel you want the
%               cutting rectangle to start from
%               pos_02 = is the position of the second pixel you want
%               the cutting rectangle to end at
%   Outputs:    image_cut = the image that is cut out 

    % Exception handling
    if(size(pos_01,2)~=2)||(size(pos_02,2)~= 2)
        error('Input arguments of rectangle position must contain two coordinates');
    end
    if((pos_01(1) == pos_02(1)) || (pos_01(2) == pos_02(2)))
        error('Rectangle needs two different points.');
    end
    if(pos_01(1) > size(input_image,1)) || (pos_01(2) > size(input_image,2)) || (pos_02(1) > size(input_image,1)) || (pos_02(2) > size(input_image,2))
        error('Rectangle not in image.');
    end
    
    % Mark the corresponding pixels
    pos_max = [max(pos_01(1),pos_02(1)),max(pos_01(2),pos_02(2))];
    pos_min = [min(pos_01(1),pos_02(1)),min(pos_01(2),pos_02(2))];
    
    image_cut = input_image(pos_min(1):pos_max(1),pos_min(2):pos_max(2));

end

