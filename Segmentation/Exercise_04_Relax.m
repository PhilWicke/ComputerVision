%% Exercise 04.02 - Relaxation labeling
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
close all;
clear all;
clc;

img = imread('segments.png');
img = cutting(img,[100,100],[150,150]);
img_lab = label_kernel(img,180);
% imshow(label2rgb(img_lab))

initial_prob = init_probs(img_lab,0.8);
updated_prob = updt_probs(initial_prob);