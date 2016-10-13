function [ label_list ] = listLabels( input_labels )
%SQUEEZELABELS Summary of this function goes here
%   Detailed explanation goes here
    

    % Count the number of different labels
    y_axis = size(input_labels,1);
    x_axis = size(input_labels,2);
    label_list = max(input_labels(:));
    
    for IDXy = 1 : y_axis 
        for IDXx = 1 : x_axis
            if ~ismember(input_labels(IDXy,IDXx),label_list) && input_labels(IDXy,IDXx) ~= 0
                label_list(end+1) = input_labels(IDXy,IDXx);
            end
        end
    end
end

