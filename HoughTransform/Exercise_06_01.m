%% Exercise 06.01 - Understanding Hough Transform
% pwicke and fwalocha

clear all;
close all;
clc;

% Create image with a single dot
blank_img = zeros(100,100);
one_dot = blank_img;
one_dot(50,50) = 1;

% If you have a single point in the image this will be converted to all the
% lines that run through this point. They are plotted on radius and angle
% axis, therefore we get the sine function for this single point
subplot(1,2,2)
one_dot_hg = hough(one_dot);
imshow(mat2gray(one_dot_hg));
title('Accumulator Space: Single Point');

subplot(1,2,1)
imshow(mat2gray(one_dot));
title('Image: Single Point');

% Create image with point in a row: Here multiple point are radially cut by
% lines and in accumulator space, by sinus functions. This leads to an
% overlap at one point in accumulator space, indicating the edge
figure;
points_01 = blank_img;
points_01(25:35,50) = 1;

subplot(1,2,2)
points_01_hg = hough(points_01);
imshow(mat2gray(points_01_hg));
title('Accumulator Space: Multiple Points');

subplot(1,2,1)
imshow(mat2gray(points_01));
title('Image: Multiple Points');

% Create image with a row: Now the radial overlap of all sinus functions
% distributes equally along the entire image, therefore only the
% intersection point is (radially) highlighted.
figure;
row_01 = blank_img;
row_01(:,25) = 1;

subplot(1,2,2)
row_01_hg = hough(row_01);
imshow(mat2gray(row_01_hg));
title('Accumulator Space: Line');

subplot(1,2,1)
imshow(mat2gray(row_01));
title('Image: Line');

% Create image with another line
figure;
row_02 = eye(100);

subplot(1,2,2)
row_02_hg = hough(row_02);
imshow(mat2gray(row_02_hg));
title('Accumulator Space: Diagonal');

subplot(1,2,1)
imshow(mat2gray(row_02));
title('Image: Diagonal');

% Create image with a triangle
figure;
shapes = rgb2gray(imread('Shapes.png'));


subplot(1,2,2)
shapes_hg = hough(shapes);
imshow(mat2gray(shapes_hg));
title('Accumulator Space: Shapes');

subplot(1,2,1)
imshow(mat2gray(shapes));
title('Image: Shapes');




