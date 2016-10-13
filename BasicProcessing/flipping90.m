function [ image_flipped ] = flipping90( input_image, n_flips, varargin )
%FLIPPING90 flips the image 90° clockwise, n times
%   Takes an input image and flips it n_flips times
%   Input:      input_image = the image that will be flipped
%               n_flips = the number fo 90° clockwise flips
%               'mirror' = boolean flag to indicate if mirroring is wanted
%   Output:     image_flipped = the image that has been flipped
    
    % take care of flips more than 360°
    n_flips = mod(n_flips,4);
    
    % mirror image at y-axis if flag is set
    if(ismember('mirror',varargin))
        input_image = input_image(:,end:-1:1);
    end

    switch n_flips
        case 1
            % reverse the x-dimension and transpose -> 90°
            image_flipped = input_image(end:-1:1,:)';
        case 2
            % reverse both dimensions -> 180°
            image_flipped = input_image(end:-1:1,end:-1:1);
        case 3
            % reverse the y-dimension and transpose -> 270°
            image_flipped = input_image(:,end:-1:1)';
        otherwise
            % return the input picture -> 360°
            image_flipped = input_image;
    end
end

