function [ output_img ] = buildRGB( x,y,red,green,blue )
%BUILDRGB Summary of this function goes here
%   Detailed explanation goes here

    output_img = uint8(cat(3,(ones(x,y)*red), ...
                             (ones(x,y)*green),...
                             (ones(x,y)*blue)));

end

