%% Exercise 01
% fwalocha, pwicke

clear all;
close all;

%% RGB distribution 

img = imread('pepper.png');
% reshape x and y axis into one dimension
img = reshape(img,[size(img,1)*size(img,2),size(img,3)]);
% color is scaled to 1 
c = double(img)./255; 

figure
scatter3(img(:,1),img(:,2),img(:,3),1,c,'.');

%% HSV distribution

img = imread('pepper.png');
img = rgb2hsv(img);
img = reshape(img,[size(img,1)*size(img,2),size(img,3)]);


[X,Y,Z] = hsv2cone(img);

figure
scatter3(X,Y,Z,1,c,'.');
