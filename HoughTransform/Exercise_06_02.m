%% Exercise 06.02 Hough Transform

% setup
clear all;
close all;
clc;

% create black canvas and draw three lines
blank_img = zeros(100,100);
one_dot = blank_img;
one_dot(:,50) = 1;
one_dot(:,60) = 1;
one_dot(:,70) = 1;

% use my_hough transform and display result
subplot(1,2,1)
imshow(one_dot);
subplot(1,2,2)
one_dot_hg = my_hough(one_dot);
imshow(one_dot_hg);

