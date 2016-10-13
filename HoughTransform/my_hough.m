function [ output_image ] = my_hough( input_img )
%MY_HOUGH implements the Standard Hough Transform. hough is designed
%     to detect lines. It uses the parametric representation of a line:
%  
%                         rho = x*cos(theta) + y*sin(theta).
%  
%     The variable rho is the distance from the origin to the line along a
%     vector perpendicular to the line.  Theta is the angle between
%     the x-axis and this vector.

    % check input for grayscale
    if ndims(input_img) ~= 2
        error('Image is not a 2D grayscale image!');
    end
    output_image = input_img;
    
    % get information about the image
    img_h = size(input_img,1);
    img_l = size(input_img,2);
    
    % get maximal and minimal distance
    max_d = sqrt((img_h)^2 + (img_l^2));
    min_d = max_d * -1;
    houghRaum = zeros(315,abs(floor(min_d))+ceil(max_d)+100);
    
    % find all lines in the image (non-zero elements)
    [X,Y] = find(input_img);
    alph = 0:314;
    alph = round(alph);
    
    % use algorithm of hough tranform to create accumulator space
    % but keep in mind the 1 indexing and 0° of alpha (see next comment)
    for IDXx = 1:size(X,1)
        for IDXa = 1:size(alph,2)

            d = round(X(IDXx)*cos(alph(IDXa)/100) + Y(IDXx)*sin(alph(IDXa)/100));
            d = d+abs(floor(min_d))+1; % start at 1 and shift all by d_min

            houghRaum(alph(IDXa)+1,d) = houghRaum(alph(IDXa)+1,d) + 1;
        end
    end
    
    % transform matrix into scaled gray value image
    output_image = mat2gray(houghRaum');
    
end

