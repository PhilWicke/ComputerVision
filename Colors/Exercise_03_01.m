%% Exercise 03.01 - Object Tracking
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc;
clear all;
close all;

%% OBJECT TRACKER
clc
url         = 'http://192.168.178.102:8080/shot.jpg';

while(1)
    snapshot  = imread(url);
    pause(0.01);
    imshow(trackObject(snapshot,30,'r'));
end

%% OBJECT DRAWER
clc
url         = 'http://192.168.178.102:8080/shot.jpg';
snapshot    = imread(url);
emptyMask   = zeros(size(snapshot));
mask        = drawingObject(snapshot,emptyMask,30,'r');



while(1)
    snapshot  = imread(url);
    pause(0.1);
    framed_img  = trackObject(snapshot,30,'r');
    mask        = uint8(drawingObject(snapshot,mask,30,'r'));
    hold on
    imshow(framed_img)
    imshow(mask);
    
end

%% a) Compute mask
% Compute a mask for the object, based on its color. First try this in the
% RGB color space.

% get snapshot from IP webcam
url         = 'http://192.168.178.72:8080/shot.jpg';
snapshot    = imread(url);  
properties  = image(snapshot);   

%% Build mask for RGB color space

threshold = 10;
   
subplot(1,2,1)
my_hist(snapshot(:,:,1))

subplot(1,2,2)
pause(0.01);
mask_rgb    = snapshot(:,:,1) - rgb2gray(snapshot);
mask_rgb    = mask_rgb >= threshold;
imshow(mask_rgb)

%% Loop
while (1)
    snapshot = imread(url);  
    subplot(1,2,1)
    my_hist(snapshot(:,:,1))
    pause(0.01)

    subplot(1,2,2)

    mask_rgb = snapshot(:,:,1) - rgb2gray(snapshot);
    mask_rgb = mask_rgb >= threshold;
    imshow(mask_rgb)
end


%% b) Build HSV color space

hsv_snap  = rgb2hsv(snapshot);

subplot(1,4,1)
imshow(hsv_snap(:,:,1))
title('hue')

subplot(1,4,2)
imshow(hsv_snap(:,:,2))
title('saturation')

subplot(1,4,3)
imshow(hsv_snap(:,:,3))
title('lightness')

subplot(1,4,4)
pause(0.01);
imshow(hsv_snap)
title('hsv')

%% Loop HSV

while (1)
    snapshot = imread(url);  
    hsv_snap  = rgb2hsv(snapshot);

    subplot(1,4,1)
    imshow(hsv_snap(:,:,1))
    title('hue')

    subplot(1,4,2)
    imshow(hsv_snap(:,:,2))
    title('saturation')

    subplot(1,4,3)
    imshow(hsv_snap(:,:,3))
    title('lightness')

    subplot(1,4,4)
    pause(0.01);
    imshow(hsv_snap)
    title('hsv')
end

%% Compute mask for HSV
hsv_snap  = rgb2hsv(imread(url));

huePer        = hsv_snap(:,:,1) <= 0.01; % define color in degree
satPer        = hsv_snap(:,:,2) >= 0.20; % define saturation in percent
valPer        = hsv_snap(:,:,3) >= 0.20; % define value of max brightness

mask_hsv          = huePer & satPer & valPer;
imshow(mask_hsv)

%% c) Remove irregularities and label segments

% perform morphological opening
se = strel('disk',5); % decide on shape of morphing 
opened_rgb = imopen(mask_rgb,se);
opened_hsv = imopen(mask_hsv,se);
subplot(1,2,1)
imshow(opened_rgb,[])
title('Opened RGB mask')

subplot(1,2,2)
imshow(opened_hsv,[])
title('Opened HSV mask')

%% Labeling of remaining components


label_mat = bwlabel(opened_rgb);
figure
subplot(1,2,1)
imshow(label_mat,colormap('lines'));
title('All segments')

% Identify target
label_num  = max(max(label_mat));
label_size = 0;
target_seg = 0;

% the elements equal to 0 are the background
for segment = 1:label_num
    temp_size  = sum(sum(label_mat == segment))
    if label_size < temp_size
        % override last highest size
        label_mat(label_mat == segment-1) = 0;
        label_size = temp_size;
        target_seg = segment;
    else
        % eliminate segment as it is not the biggest
        label_mat(label_mat == segment) = 0;
    end
end

subplot(1,2,2)
imshow(label_mat,colormap('lines'));
title('Segmentation of biggest')


%% d) Find object in image
label_mat(label_mat == target_seg) = 1;
figure
imshow(label_mat)
title('Segmentation of biggest')

%% find all non-zero entries in mask
[rows, cols] = find(label_mat);
% get min and max coordinates to define rectangle
tmaxX = max(cols);
tmaxY = max(rows);
tminY = min(rows);
tminX = min(cols);

marked_img = mark_RGB(snapshot,[tmaxY,tmaxX],[tminY,tminX],'b');
% draw thicker boundary:
marked_img = mark_RGB(marked_img,[tmaxY-1,tmaxX-1],[tminY-1,tminX-1],'b');
imshow(marked_img)

%% For other colors you need to adjust the threshold!

snapshot01 = imread('snapshot01.png');
subplot(1,3,1)
imshow(trackObject(snapshot01,'g'));
snapshot02 = imread('snapshot02.png');
subplot(1,3,2)
imshow(trackObject(snapshot02,'r'));
snapshot03 = imread('snapshot03.png');
subplot(1,3,3)
imshow(trackObject(snapshot03,'r'));

