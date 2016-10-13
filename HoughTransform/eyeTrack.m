function [ output_img ] = eyeTrack( input_img )
%EYETRACK Summary of this function goes here
%   Detailed explanation goes here
    
    output_img = input_img;
    
    circles = ipl_find_circle(output_img);

end

