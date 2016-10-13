%% Exercise 01.03 - Point operators
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc
clear all 
close all

% read the image and invert by substracting from 255
image_01 = imread('coins.png');
image_inv = 255 - image_01;

% plot solution
subplot(1,2,1)
imshow(image_01);
title('Original');
subplot(1,2,2)
imshow(image_inv);
title('Inverted');

%% Histogram

% reshape the image from 2D(246x300) into 1D(73800) 
image_vec = reshape(image_01,1,size(image_01,1)*size(image_01,2));

% plot histogram but use call double and assign 255 bins
figure;
subplot(1,2,1);
hold on;
hist(double(image_vec),255); 
plot(80:80,0:4500,'r'); % plot threshold
title('Matlab Histogram');
xlabel('Gray Values');
ylabel('Count');

% using own hist function which appear to be a lot more sophisticated ;)
subplot(1,2,2);
hold on;
plot(80:80,0:4500,'r'); % plot threshold
my_hist(image_01);
title('Our Histogram');
xlabel('Gray Values');
ylabel('Count');

%% Binarization

% Set the threshold and binarize!
threshold = 80;
[mask01,mask02] = binarize(image_01,80);

% Plot the original image and both masks
figure;
subplot(1,3,1);
imshow(image_01);
title('Original')
subplot(1,3,2)
imshow(mask01);
title('Mask > Threshold'); 
subplot(1,3,3)
imshow(mask02);
title('Mask < Threshold');

% Use the mask to delete background









