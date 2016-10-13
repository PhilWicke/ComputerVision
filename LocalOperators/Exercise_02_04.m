%% Exercise 02.04 - Morphological operators
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc
clear all 
close all

img = double(imread('note.png'));
empt_kernel     = [0,0,0;0,0,0;0,0,0]; 

% Apply erosion and dilation
img_erode = my_conv(img,empt_kernel,'erode');
img_dilat = my_conv(img,empt_kernel,'dilate');

%% Plot Erosion and Dilation
figure
subplot(1,3,1)
imshow(img)
title('Original')
subplot(1,3,2)
imshow(double(img_erode))
title('Erosion')
subplot(1,3,3)
imshow(double(img_dilat))
title('Dilation')

%% Distance Transform

image = imread('leaf.png');
figure()
imshow(my_bwdist(image,'octagon'));

%% Distance transform images

imgA = rgb2gray(imread('cat.png'));
imgB = rgb2gray(imread('dog.png'));

distA = bwdist(imgA);
distB = bwdist(imgB);

figure()
subplot(1,2,1)
title('Cat Distance Transform');
imshow(distA,[])
subplot(1,2,2)
title('Dog Distance Transform');
imshow(distB,[])

%% Plot Morphed Images

figure()
subplot(1,4,1)
imshow(img_morph(imgA,imgB,0));
title('0% Dog');
subplot(1,4,2)
imshow(img_morph(imgA,imgB,25));
title('25% Dog');
subplot(1,4,3)
imshow(img_morph(imgA,imgB,75));
title('75% Dog');
subplot(1,4,4)
imshow(img_morph(imgA,imgB,100));
title('100% Dog');











