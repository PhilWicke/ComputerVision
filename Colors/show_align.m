function [image,cvals] = show_align(image,func,varargin)
%SHOW_ALING Processes image through cutting and shows it
%   The alignment boundaries are hard coded due to a fixed size
%   Inputs:     image = in our case a webcam snapshot
%               func = function to process and visualize cam (e.g.imshow)
%               varargin = if comparators exist, compare to new image

% Bounds for white frame and cutout
low_bound_Y = round(1/10*size(image,1)); 
low_bound_X = round(8/28*size(image,2));
high_bound_Y = round(9/10*size(image,1));
high_bound_X = round(18/28*size(image,2));

% Create a white frame around critical area
image(low_bound_Y:high_bound_Y,low_bound_X,1) = 255;
image(low_bound_Y:high_bound_Y,high_bound_X,1) = 255;
image(low_bound_Y,low_bound_X:high_bound_X,1) = 255;
image(high_bound_Y,1:low_bound_X,1)            = 255;
image(high_bound_Y,high_bound_X:end,1)        = 255;

% Set every value to 255, making the frame white
image(low_bound_Y:high_bound_Y,low_bound_X,2) = 255;
image(low_bound_Y:high_bound_Y,high_bound_X,2) = 255;
image(low_bound_Y,low_bound_X:high_bound_X,2) = 255;
image(high_bound_Y,1:low_bound_X,2)            = 255;
image(high_bound_Y,high_bound_X:end,2)        = 255;

image(low_bound_Y:high_bound_Y,low_bound_X,3) = 255;
image(low_bound_Y:high_bound_Y,high_bound_X,3) = 255;
image(low_bound_Y,low_bound_X:high_bound_X,3) = 255;
image(high_bound_Y,1:low_bound_X,3)            = 255;
image(high_bound_Y,high_bound_X:end,3)        = 255;

% Cut out critical area (head and shoulders)
img_reduced = zeros(size(image)); 

% Head
img_reduced(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,1) = ...
        image(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,1);
img_reduced(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,2) = ...
        image(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,2);
img_reduced(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,3) = ...
        image(low_bound_Y:high_bound_Y,low_bound_X:high_bound_X,3);
    
% Shoulders    
img_reduced(high_bound_Y:end,:,1) = image(high_bound_Y:end,:,1);
img_reduced(high_bound_Y:end,:,2) = image(high_bound_Y:end,:,2);
img_reduced(high_bound_Y:end,:,3) = image(high_bound_Y:end,:,3);

% Receive color characteristics of provided image
cvals = col_stats(rgb2hsv(img_reduced));
subplot(1,2,1)
%(Further process and) show image
func(image);
if(nargin>2)
    % Function to compare new image to comparators with hardcoded names
    %  of group members
    [name, dev] = comp_vals(cvals,varargin{:},'Member 1',...
                                            'Member 2','Member 3');
    % Print out the name and deviance of member with the least deviation
    title(sprintf('Member = %s with deviation %s', name, int2str(dev)))
end

%Show color characteristics
subplot(1,2,2)
h = bar(cvals);
title('1: red, 2: yellow, 3: green, 4: blue, 5: purple')

end