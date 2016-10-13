%% Eye Tracker
% pwicke, fwalocha

clear all;
close all;
clc;

disp('Please place eyes in the marked region.')
url = 'http://192.168.178.102:8080/shot.jpg';
[radius, threshold] = eye_tracker(url,'setup');
disp('Press any key, when ready.')
eye_tracker(url,'track',radius,threshold);
