function [ output_image ] = noise_saltpepper( input_image, percentage )
%NOISE_SALTPEPPER distributes black and white pixels according to
%percentage on the given image
%   Input:      input_image = the image you want to put salt and pepper
%               noise onto
%               percentage = the percentage of noise you want to apply
%   Output:     output_image = the distorted image
    
    % create a layer with random distributed values in size of input img
    layer_bw  = rand([size(input_image,1),size(input_image,2)]);
    
    if ndims(input_image) == 3
        % concatenate the layers three times, for each color value once
        layer_bw  = cat(3,layer_bw,layer_bw,layer_bw);
    end
    
    % divide salt and pepper equally 
    input_image(layer_bw <= percentage) = 0;
    input_image(layer_bw <= percentage/2) = 255;
    
    % give output
    output_image = input_image;
end

