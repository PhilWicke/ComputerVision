function [ output_image ] = noise_gauss( input_image, sigma )
%GAUSS_NOISE Applies a gaussian distributed noise to an image of either
%gray scale or RGB quality. 
%   Inputs:     input_image = the input image whitch can either be a RGB or
%                             grayscale image
%               sigma       = the variance of the gaussian distributed
%                             noise
%   Outputs:    output_image= the noisy image
    
    % allocate space for image
    output_image = zeros(size(input_image));
    % iterate through columns and rows
    if ndims(input_image) == 2 % for gray scale
        for IDX1 = 1:size(input_image,1)
            for IDX2 = 1:size(input_image,2)
                % use random function with sigma
                output_image(IDX1,IDX2) = random('Normal', input_image(IDX1,IDX2),sigma);
            end
        end
    elseif ndims(input_image) == 3 % for RGB
        for IDXrow = 1:size(input_image,1)
            for IDXcol = 1:size(input_image,2)
                for IDXval = 1:size(input_image,3)
                   output_image(IDXrow,IDXcol,IDXval) = random('Normal',input_image(IDXrow,IDXcol,IDXval),sigma);
                end
            end
        end
    else
        error('Image type not supported error.')
    end
    % output noised image in uint8-format
    output_image = uint8(output_image);
end

