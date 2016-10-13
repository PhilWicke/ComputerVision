%% Exercise 04.01 - Region labeling
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

clear all;
close all;
clc;

img = imread('segments.png');
img_lab = label_kernel(img,190);

figure();
subplot(2,2,1)
imshow(label2rgb(img_lab, 'prism', 'C', 'shuffle'))
title('Basic Labeling')

% opening
se = strel('disk',1); 
opened_rgb = imopen(img,se);
img_open = label_kernel(opened_rgb,150);

subplot(2,2,2)
imshow(label2rgb(img_open, 'prism', 'C', 'shuffle'))
title('Preproc: Opening')

% median filter
img_med = label_kernel(medfilt2(img),190);

subplot(2,2,3)
imshow(label2rgb(img_med, 'prism', 'C', 'shuffle'))
title('Preproc: Median')

% remove lebels with less than 'n' pixels
n = 50;
max_label = max(img_lab(:));
img_labN  = img_lab;

for IDXlab = 1:max_label
    if sum(sum(img_labN==IDXlab)) < n 
        img_labN(img_labN==IDXlab) = 0;
    end
end

subplot(2,2,4)
imshow(label2rgb(img_labN, 'prism', 'C', 'shuffle'))
title('Label size threshold');