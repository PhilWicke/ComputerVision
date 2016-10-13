%% Exercise 02 - k-means clustering
% pwicke fwalocha

clear all;
close all;
clc;

% Variables
img         = imread('peppers.png');
cluster_num = 4;

% Calculation
cluster_mask = my_kmeans(img,cluster_num,10);

%% Presentation
colors = zeros(size(cluster_mask,1),3);


for IDXclus = 1:cluster_num
    mask = cluster_mask == IDXclus;
    colors(find(mask),:) = repmat(rand(3,1)',size(colors(find(mask),:),1),1);
end
figure
scatter3(img(:,1),img(:,2),img(:,3),1,colors,'.');

figure
cluster_labs = reshape(colors,[size(img,1),size(img,2),size(img,3)]);
imshow(cluster_labs)
title('Cluster');

%% HSV Clustering

cluster_num = 4;

img = imread('pepper.png');
img = rgb2hsv(img);
img_x = reshape(img,[size(img,1)*size(img,2),size(img,3)]);

[X,Y,Z] = hsv2cone(img_x);
img_x(:,1) = X;
img_x(:,2) = Y;
img_x(:,3) = Z;
img_y = reshape(img_x,size(img));

cluster_HSV = my_kmeans(img_y,cluster_num,0.01);

%% HSV Representation

colors = zeros(size(cluster_HSV,1),3);


for IDXclus = 1:cluster_num
    mask = cluster_HSV == IDXclus;
    colors(find(mask),:) = repmat(rand(3,1)',size(colors(find(mask),:),1),1);
end
figure
scatter3(img_x(:,1),img_x(:,2),img_x(:,3),1,colors,'.');

figure
cluster_labHSV = reshape(colors,[size(img,1),size(img,2),size(img,3)]);
imshow(cluster_labHSV)
title('Cluster in HSV');