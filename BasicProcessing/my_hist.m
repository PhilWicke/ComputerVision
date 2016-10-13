function [ ] = my_hist(input_image)
%MY_HIST does the same as the hist() function of Matlab
%   Takes an image and returns a histogram of its gray values
%   Input: The image to get the histogram from
%   Output: nothing, but shows the histogram of gray values

    gvals = zeros(255,1);
    for IDX = 1:255
        % get columns with first sum, add up to one value with second sum
        gvals(IDX) = sum(sum(input_image==IDX));  
    end
    bar(gvals)

end



