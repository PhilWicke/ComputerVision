%% Exercise 01.04 - Dyadic operators / video processing
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

%setup
clear all;
close all;

%% Image Aquisition

% Construct a questdlg with three options
choice = questdlg('Which part of the program do you want to see?', ...
	'Choose an option', ... 
    'Original Video Stream', ...
	'Motion Detection', ...
    'Background Substraction', ... 
    'Original Video Stream'); 

% Preprocessing of image information
url         = 'http://192.168.178.72:8080/shot.jpg';
snapshot    = imread(url);  
properties  = image(snapshot);   

% Handle response
switch choice
    
    % Start image aquisition and display the regular stream
    case 'Original Video Stream'
        
        disp('Original Video Stream running...')
        % take infinitely many screenshots to simulate video
        while(1)
            snapshot  = imread(url);
            set(properties,'CData',snapshot);
            drawnow;
        end
        
    % Start the case of motion detection
    case 'Motion Detection'
        disp('Motion Detection running...')
        
        % Take an image (img) and substract the next one from it
        % If the difference is above the threshold we get img2.*1 and
        % this can be seen as motion. If its below than the diff_img
        % remains black at this place img2.*0
        img = rgb2gray(imread(url));
        while 1
            img2 = rgb2gray(imread(url));
            diff_img = img2 .* uint8((img-img2)>10);
            set(properties,'CData',diff_img);
            drawnow;
            img = img2;
        end
    
    % Start Background Substraction
    case 'Background Substraction'
        % We obtain a background image by averaging over 100 sample pictures
        disp('Starting Background Substraction...')
        back = zeros(size(snapshot,1),size(snapshot,2),size(snapshot,3),100);
        %01 back = zeros(size(snapshot,1),size(snapshot,2),100);
        disp('Start taking sample pictures for background...')
        for shot = 1:100
            back(:,:,:,shot) = imread(url);
            %02 back(:,:,shot) = rgb2gray(imread(url));
        end
        disp('...background evaluated.')
        back = uint8(mean(back,4));
        %03 back = uint8(mean(back,3));
        set(properties,'CData',back);
        drawnow;

        while 1
            img2 = imread(url);
            %04 img2 = rgb2gray(imread(url));
            diff_img2 = img2 .* uint8((back-img2)>20);
            % Plot difference from background
            set(properties,'CData',diff_img2);
            drawnow;
        end
        
end






