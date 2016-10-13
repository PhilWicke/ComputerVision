function [cvals] = col_stats(input_image)
%COL_STATS  creates bins for certain color ranges for an image
%   Based on hue angles, pixels are put into bins and returned for
%   comparison

% The angles are calculated by eyeballing 

% size 70
red = ones(100,1);
red(1:70) = [1:40, 331:360];
red = red';
%size 40
yellow = ones(100,1).*41;
yellow(1:40) = 41:80;
yellow = yellow';
%size 90
green = ones(100,1).*81;
green(1:90) = 81:170;
green = green';
%size 100
blue = 171:270;
%size 60
purple = ones(100,1).*271;
purple(1:60) = 271:330;
purple = purple';

% Color characteristics of 5 color ranges, adding more is possible
colors = [red; yellow; green; blue; purple];

img_hue = round(input_image(:,:,1).*360);

cvals = zeros(5,1);    
for IDX = 1:size(colors,1);
    % Also, very dark parts (such as cutoffs) are not considered
    mask = ((ismember(img_hue, colors(IDX,:)))...
        +(input_image(:,:,3)>0.1))==2;
    cvals(IDX) = sum(sum(mask));  
end

end

