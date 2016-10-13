%% Exercise 01.01 - Matlab Intro
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc
clear all 
close all

% define area of interest
pos_01 = [20,80];
pos_02 = [100,150];

% read image and display image
image_01 = imread('cameraman.tif');
imshow(image_01);

% use the rectangle_head function
image_rec = mark_rec(image_01,pos_01,pos_02);
% use the cutting function
image_cut = cutting(image_01,pos_01,pos_02);

% plotting
figure;
subplot(1,2,1);
imshow(image_rec);
subplot(1,2,2);
imshow(image_cut);

%% Flipping / Mirroring

% use flipping function
flip_00 = flipping90(image_01,4);
flip_01 = flipping90(image_01,1);
flip_02 = flipping90(image_01,2);
flip_03 = flipping90(image_01,3);

% use mirror argument 
flip_04 = flipping90(image_01,4,'mirror');
flip_05 = flipping90(image_01,1,'mirror');
flip_06 = flipping90(image_01,2,'mirror');
flip_07 = flipping90(image_01,3,'mirror');

% Plotting unmirrored
figure;
subplot(2,4,1);
imshow(flip_00);
subplot(2,4,2);
imshow(flip_01);
subplot(2,4,3);
imshow(flip_02);
subplot(2,4,4);
imshow(flip_03);

% plot use of mirroring function
subplot(2,4,5);
imshow(flip_04);
subplot(2,4,6);
imshow(flip_05);
subplot(2,4,7);
imshow(flip_06);
subplot(2,4,8);
imshow(flip_07);
