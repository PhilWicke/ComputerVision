%% Exercise 06.03 Circular Hough Transform
% pwicke,fwalocha

clear all;
close all;
clc;

face = imread('pic01.png');

subplot(1,2,1)
imshow(face);
subplot(1,2,2)
[circY,circX] = my_circHough(rgb2gray(face),3,0);
imshow(face);
hold on;
plot(circX,circY,'r.','MarkerSize',1);
