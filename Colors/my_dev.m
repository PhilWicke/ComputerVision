function [ deviance ] = my_dev(hist1, hist2)
%MY_DEV Calculate deviance of 2 color characteristics
%   Calculated standart deviation of the sum of differences
var = (hist1-hist2).^2;

deviance = sqrt(sum(var(:)));

end

