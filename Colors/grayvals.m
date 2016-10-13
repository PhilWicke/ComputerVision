function [ output_vals ] = grayvals(input_image)
%MY_GVALS 



    gvals = zeros(255,1);
    for IDX = 1:255
        % get columns with first sum, add up to one value with second sum
        gvals(IDX) = sum(sum(input_image==IDX));  
    end
    output_vals = gvals;

end



