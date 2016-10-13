%% Exercise 03.01 - Object recognition
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc;
clear all;
close all;

%% Compute color characteristic

url         = 'http://192.168.178.102:8080/shot.jpg';
snapshot    = imread(url);  


%% Obtain a background image
back = zeros(size(snapshot,1),size(snapshot,2),size(snapshot,3),100);
disp('Start taking sample pictures for background in 3 seconds.')
pause(3)
disp('Sampling...')
for shot = 1:100
    back(:,:,:,shot) = imread(url);
    %02 back(:,:,shot) = rgb2gray(imread(url));
end
disp('Done. Background evaluated')
back = uint8(mean(back,4));

%% Reading the first object
disp('Place first object in front of camera in 3 seconds.')
pause(3)
disp('Analysing object.')
obj01_img = imread(url);
obj01_img = obj01_img .* uint8((back-obj01_img)>50);

figure
hold on;
my_hist(obj01_img(:,:,1),'r');
my_hist(obj01_img(:,:,2),'b');
my_hist(obj01_img(:,:,3),'g');
xlim([1 150]); 
hold off

red_sum_o1   = sum(sum(obj01_img(:,:,1)));
green_sum_o1 = sum(sum(obj01_img(:,:,2)));
blue_sum_o1  = sum(sum(obj01_img(:,:,3)));

%% Get Data

for IDX = 1:10
    disp('Place object in new perspective now.')
    pause(3)
    disp('*CLICK*')
    obj01_img = imread(url);
    obj01_img = obj01_img .* uint8((back-obj01_img)>50);
    for IDXcol = 1:3
        X(IDX,IDXcol) = sum(sum(obj01_img(:,:,IDXcol)));
    end
end
disp('First object scanned.')
pause(3)
disp('Place NEW object now.')
pause(3)
for IDX = 11:21
    disp('Place object in new perspective now.')
    pause(3)
    disp('*CLICK*')
    obj01_img = imread(url);
    obj01_img = obj01_img .* uint8((back-obj01_img)>50);
    for IDXcol = 1:3
        X(IDX,IDXcol) = sum(sum(obj01_img(:,:,IDXcol)));
    end
end

figure
hold on
plot(1:21,X(:,1),'r')
plot(1:21,X(:,2),'g')
plot(1:21,X(:,3),'b')
hold off;






