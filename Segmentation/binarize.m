function [ mask01, mask02 ] = binarize( input_image, threshold )
%BINARIZE takes an input image and a threshold and return the binarized
%image
%   Input:      input_image = the image that will be binarized
%               threshold   = pixels above this 0-255 gray scale will be
%               turned white, below the threshold, they will be turned
%               black
%   Output:     mask01 = is the threshold mask for all values above threshold
%               mask02 = is the threshold mask for all values below threshold

    % check threshold sanity
    if (threshold <= 1) || (threshold >= 255)
        error('Threshold not in grayscale. Must be a value between 0 and 255.');
    end
    
    % take original image and replace each pixel above threshold by 255
    mask01 = input_image;
    mask01(input_image >= threshold) = 255;
    mask01 = uint8(mask01);
    
    % take original image and replace each pixel below threshold by 1
    mask02 = input_image;
    mask02(input_image <= threshold) = 1;
    mask02 = uint8(mask02);
end

