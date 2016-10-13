%% Exercise 02.03 - Non-linear smoothing
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc;       
clear all;
close all;

% load images
image           = imread('car.jpg');
img_gauss       = noise_gauss(image,30);
img_sp          = noise_saltpepper(image,0.02);
empt_kernel     = [0,0,0;0,0,0;0,0,0]; 

%% Evaluate min max convolution

img_min_gauss         = my_conv(img_gauss,empt_kernel,'border','min');
img_max_gauss         = my_conv(img_gauss,empt_kernel,'border','max');

img_min_sp            = my_conv(img_sp,empt_kernel,'border','min');
img_max_sp            = my_conv(img_sp,empt_kernel,'border','max');

%% Plot min max performance

figure()
subplot(2,3,1)
imshow(img_gauss)
title('gauss')

subplot(2,3,2)
imshow(img_min_gauss)
title('img min gauss')

subplot(2,3,3)
imshow(img_max_gauss)
title('img max gauss')

subplot(2,3,4)
imshow(img_sp)
title('img sp')

subplot(2,3,5)
imshow(img_min_sp)
title('img min sp')

subplot(2,3,6)
imshow(img_max_sp)
title('img max sp')

%% Evaluating median convolution

img_med_gauss      = my_conv(img_gauss,empt_kernel,'border','median');
img_med_sp         = my_conv(img_sp,empt_kernel,'border','median');

%% Plot median performance

figure()
subplot(2,2,1)
imshow(img_gauss)
title('gauss')

subplot(2,2,2)
imshow(img_med_gauss)
title('img med gauss')

subplot(2,2,3)
imshow(img_sp)
title('img sp')

subplot(2,2,4)
imshow(img_med_sp)
title('img med sp')

%% Evaluating Symmetric Nearest Neighbour

img_snn_gauss      = my_conv(img_gauss,empt_kernel,'border','snn');
img_snn_sp         = my_conv(img_sp,empt_kernel,'border','snn');

%% Plot SNN performance

figure()
subplot(2,2,1)
imshow(img_gauss)
title('gauss')

subplot(2,2,2)
imshow(img_snn_gauss)
title('img snn gauss')

subplot(2,2,3)
imshow(img_sp)
title('img sp')

subplot(2,2,4)
imshow(img_snn_sp)
title('img snn sp')
