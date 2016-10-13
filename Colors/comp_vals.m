function [name, deviance] = comp_vals(cval_new, cval1, cval2, varargin)
%COMP_VALS  Compares the color characteristics to comparators
%   The function calculates the minimum deviance (calculated by my_dev)
%   and returns the name of the image(in our case name of member) of the
%   comparator with the least deviance
%   Inputs:     cval_new = color characteristics of the new image
%               cval1, cval2 = color characteristics of at least 2 other
%                              images
%               varargin = (further comparators and) the names of all the 
%                           comparator images
%
%   Outputs:    name = name of winner
%               deviance = deviation of the winning image to new image

%Calculate the amount of comparators
%size(varargin,2) = 2*peops-2
%-> peops = (size(varargin,2)+2)/2
num_peops = (size(varargin,2)+2)/2;

% amout of bins in characteristics x amount of comparators
cvals = zeros(size(cval_new,1),num_peops);
cvals(:,1) = cval1;
cvals(:,2) = cval2;

% Add further comparators
for IDX = 3:num_peops
    cvals(:,IDX) = varargin{IDX-2};
end


devs = zeros(num_peops,1);
for IDX = 1:num_peops
    devs(IDX) = my_dev(cval_new,cvals(:,IDX));
end


% Calculate the minimum deviation to new image
[deviance, index] = min(devs);

for IDX = 1:num_peops
    data(IDX,:) = varargin{IDX+(num_peops-2)};
end

% Get the name of the winner
celldata = cellstr(data);
name = celldata{index};

end