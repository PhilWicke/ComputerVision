%% Exercise 02.02 - Edge Detection
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc;
clear all;
close all;

% load image
img = double(imread('car.jpg'));

% prepare filters (could be implemented as function, 
% if there would be a second life)
prewitt0         = (1/3)*[1,0,-1;1,0,-1;1,0,-1];
prewitt90        = (1/3)*[1,1,1;0,0,0;-1,-1,-1];
prewitt45        = (1/3)*[0,-1,-1;1,0,-1;1,1,0];
prewitt135       = (1/3)*[-1,-1,0;-1,0,1;0,1,1];

sobel0           = (1/4)*[1,0,-1;2,0,-2;1,0,-1];
sobel90          = (1/4)*[1,2,1;0,0,0;-1,-2,-1];
sobel45          = (1/4)*[0,-1,-2;1,0,-1;2,1,0];
sobel135         = (1/4)*[-2,-1,0;-1,0,1;0,1,2];

laplace          = [0,1,0;1,-4,1;0,1,0];

%% Apply prewitt convolution

img_prewitt0     = my_conv(img,prewitt0,'border');
img_prewitt90    = my_conv(img,prewitt90,'border');
img_prewitt45    = my_conv(img,prewitt45,'border');
img_prewitt135   = my_conv(img,prewitt135,'border');

img_prewitt      = img_prewitt0+img_prewitt90+img_prewitt45+img_prewitt135;

%% Plot prewitt convolution

figure();
subplot(2,2,1)
imshow(img_prewitt0)
title('Vertical Prewitt');
subplot(2,2,2)
imshow(img_prewitt90)
title('Horizontal Prewitt');
subplot(2,2,3)
imshow(uint8(img))
title('Original Image');
subplot(2,2,4)
imshow(img_prewitt)
title('All Directions Prewitt');

%% Apply sobel convolution

img_sobel0     = my_conv(img,sobel0,'border');
img_sobel90    = my_conv(img,sobel90,'border');
img_sobel45    = my_conv(img,sobel45,'border');
img_sobel135   = my_conv(img,sobel135,'border');

img_sobel      = img_sobel0+img_sobel90+img_sobel45+img_sobel135;

%% Plot sobel convolution

figure();
subplot(2,2,1)
imshow(img_sobel0)
title('Vertical sobel');
subplot(2,2,2)
imshow(img_sobel90)
title('Horizontal sobel');
subplot(2,2,3)
imshow(uint8(img))
title('Original Image');
subplot(2,2,4)
imshow(img_sobel)
title('All Directions sobel');

%% Compare sobel / prewitt

figure()
subplot(1,2,1)
imshow(img_sobel)
title('All Directions sobel');
subplot(1,2,2)
imshow(img_prewitt)
title('All Directions Prewitt');

%% Apply Laplace

image = double(imread('building.jpg'));

%% laplace
laplace                 = [0,0,0;0,-2,1;0,1,0];
img_laplace             = my_conv(image,laplace,'border','laplace');
img_laplace_thresh      = my_conv(image,laplace,'border','laplace');

%% Plot Laplace
figure()
subplot(1,2,1)
imshow((img_laplace))
subplot(1,2,2)
imshow((img_laplace_thresh))

