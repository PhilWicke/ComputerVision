function [ output_image ] = my_bwdist( input_image, type )
%MY_DBWDIST Naive distance transform by using imerode multiple times 
%   type is the type of erosion
%       use: 'octagon' or 'squared'


    output_image = input_image;

    diff_img = zeros(size(output_image));
    ero_img = output_image;
    t=1;

    % for all pixels
    while any(ero_img(:))
        % strel('square',3) specify kernel: 3x3 squared
        ero_img2 = imerode(ero_img,strel(type,3));
        % at point where new border appeared assign (t) weighted value
        diff_img = diff_img + t*(ero_img~=ero_img2);
        % increase weight for brightness increase
        t=t+1;
        % recursion
        ero_img = ero_img2;

    end

    % scale diff_img to 255 gray values
    diff_img = (diff_img/max(diff_img(:))*255);
    
    output_image = uint8(diff_img);
end

