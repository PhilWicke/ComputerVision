%% Exercise 01.02 - Noise
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc
clear all 
close all

% read image and display image
image_01 = imread('cover01.jpg');       % RGB
% image_01 = imread('cameraman.tif');   % BW

figure;
subplot(1,3,1);
imshow(image_01);
title('Original');

% Apply the noise
subplot(1,3,2);
imshow(noise_gauss(image_01, 50));
title('Gauss');
subplot(1,3,3);
imshow(noise_saltpepper(image_01,0.01));
title('Salt and Pepper');

%% Temporal smoothing

% set parameters 
dist_lvl = 0.10;
num_imgs = 8;
num_smth = [2,4,8];

% adding salt and pepper:
% we plot all 'n' noisy pictures 
figure
for n = 1:num_imgs
    image_dist(:,:,:,n) = noise_saltpepper(image_01,dist_lvl);
    subplot(2,num_imgs/2,n);  % dynamical subplot
    imshow(image_dist(:,:,:,n));
    title(n);
end


figure
idx = 1;
% iterate through the number of images you take for the smoothing process
% and show the results of the different 'n' fold smoothing processes
for n = num_smth
    subplot(1,size(num_smth,2),idx) % dynamical subplot
    image_temp = image_dist(:,:,:,1:n);  % cut down number of images
    image_temp = uint8((1/n)*sum(image_temp,4)); % apply salt&pepper
    imshow(image_temp);
    title(n);
    idx = idx + 1;  % idx+=1 (python:matlab,1:0)
end
