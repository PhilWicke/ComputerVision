function [ img_labeled ] = label_kernel( input_image, threshold )
%MY_CONV my_conv( input_image, varargin )
%
%   Inputs: input_image = 

    % Binarize the input image
    [mask01, img_bin] = binarize(input_image,threshold);
    img_bin             = img_bin ~= 1;
    
    
    % provide zero-padded frame
    input_padded = zeros(size(img_bin,1)+2, size(img_bin,2)+2);
    input_padded(2:end-1, 2:end-1) = img_bin;        
    img_bin = input_padded;
    clearvars input_padded;

    y_axis = size(img_bin,1);
    x_axis = size(img_bin,2);
    
    label_num = 2;
    img_labeled = img_bin;
    
    for IDXy = 2 : y_axis % 1:y-axis w.r.t. patch size
        for IDXx = 2 : (x_axis - 1) % 1:x-axis w.r.t. patch size
            if img_bin(IDXy,IDXx) ~= 0
                %              row above input pixel&1 pixel to the left
                patch = [img_labeled(IDXy-1,IDXx-1:IDXx+1),img_labeled(IDXy,IDXx-1)];
                if sum(patch(:))==0
                    img_labeled(IDXy,IDXx) = label_num;
                    label_num = label_num+1;
                    % patch(find(patch)) acesses non-zero elems
                else
                    % With a patchsize of 4, only 2 labels can mismatch
                    img_labeled(IDXy,IDXx) = min(patch(find(patch)));
                    % Handle two mismatching labels:
                    % if not all non-zero elems are equal (to the smallest)
                    if ~all(patch(find(patch))== min(patch(find(patch))))
                        % then assign the bigger label to be equal the
                        % smaller one (e.g. 2,4 assign label 4 = 2
                        img_labeled(img_labeled==max(patch(find(patch)))) = ...
                            min(patch(find(patch)));
                    end
                end
            end
        end
    end
end


