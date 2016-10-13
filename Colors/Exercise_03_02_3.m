%% Exercise 2
clear all;
close all;

%% Initialize cam
cam = webcam('Microsoft LifeCam Front')

% Working with 3 members, adding more is possible 
%(needs to add more names in the parameters of comp_values in show_align)
% Adding more distict bins for color characteristic is possible
%(needs to change ranges and amount in col_stats)

%% Member 1
%camera loop receives show_align, show_align receives imshow
[img1,cvals1] = camera_loop(cam, @show_align, @imshow);

%% Member 2
[img2,cvals2] = camera_loop(cam, @show_align, @imshow);

%% Member 3
[img3,cvals3] = camera_loop(cam, @show_align, @imshow);

%% New image comparison
%camera loop receives show_align, show_align receives imshow
[img,cvals] = camera_loop(cam, @show_align, @imshow, cvals1, cvals2, cvals3);

%%
clear all;
close all;
