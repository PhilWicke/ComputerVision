%% Exercise 1

clear all;
close all;

%% Initialize cam
cam = webcam('Microsoft LifeCam Front');

%% Track object based on color
camera_loop(cam, @trackNshow, @trackObject, 30, 'b');

%% OBJECT DRAWER (WIP, doesn't seem to work?)
snap    = snapshot(cam);
emptyMask   = zeros(size(snap));
mask        = drawingObject(snap,emptyMask,20,'b');


global KEY_IS_PRESSED 
KEY_IS_PRESSED = 0; 
fig = figure; 
%Binds variable to mechanic action via myKeyPressFcn
set(fig, 'KeyPressFcn', @myKeyPressFcn) 

while ~KEY_IS_PRESSED
    snap  = snapshot(cam);
    framed_img  = trackObject(snap,20,'b');
    mask        = drawingObject(snap,mask,20,'b');
    imshow(uint8(double(framed_img)+mask));    
end
close(fig);
