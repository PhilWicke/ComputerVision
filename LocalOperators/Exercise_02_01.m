%% Exercise 02.01 - Convolution
% Fabian Walocha and Philipp Wicke
% fwalocha(954372), pwicke(954242)

% setup
clc
clear all 
close all

% load image and kernel
image           = imread('car.jpg');
[kernel,vector] = gauss_kernel(3);
gauss_ker    = kernel;
gauss_vec    = vector;


disp('Binomial approximation from the lecture:');
tic
kernel_01       = my_conv(image,gauss_ker);
toc

%% Show images in comparison: Simple Gauss
subplot(1,3,1)
imshow(image)
title('Original');

subplot(1,3,2)
imshow(kernel_01)
title('Bin.Appr. Kernel')
subplot(1,3,3)
imshow(kernel_01 == uint8(image))
title('Difference image')

%% Use border padding
disp('Binomial approximation from the lecture w/ border padding:');

kernel_03_1       = my_conv(image,gauss_ker,'border');
kernel_03_2       = my_conv(image,gauss_ker,'border');
kernel_03_3       = my_conv(image,gauss_ker,'border');

%% Show images in comparison: Border Padded
figure()
subplot(2,3,1)
imshow(image)
title('Original');

subplot(2,3,2)
imshow(kernel_03_1)
title('Bin.Appr. w/ black border')

subplot(2,3,3)
imshow(kernel_03_2)
title('Bin.Appr. w/ multipic border')

subplot(2,3,4)
imshow(kernel_03_3)
title('Bin.Appr. w/ mirrorpic border')

%% Speed test: Separation vs. No Separation

disp('Time without seperation:')
tic
kernel_06       = my_conv(image,gauss_ker);
toc
disp('Time with seperation:')
tic
kernel_07       = my_conv(image,gauss_vec,'separate');
toc


%% Massive Speed Eval
kernel_sizes = [3,21,101];
trial_number = 10; 

%% separation regular method with 1,9,17 kernel sizes in 10 trials
separated = zeros(size(kernel_sizes,2),trial_number);

disp('Separated:')
IDX = 1;
for count = kernel_sizes
    [kernel,vector] = gauss_kernel(count);
    gauss_ker    = kernel;
    gauss_vec    = vector;
    for trial = 1:trial_number
        disp('Count: ')
        disp(count)
        disp('Trial: ')
        disp(trial)
        tic
        my_conv(image,gauss_vec,'separate');
        separated(IDX,trial) = toc;
    end
    IDX = IDX +1;
end
% save('separated.mat','separated');

%% no separation regular method with 1,5 kernel sizes in 50 trials
unseparated = zeros(size(kernel_sizes,2),trial_number);

disp('Unseparated:')
IDX = 1;
for count = kernel_sizes
    [kernel,vector] = gauss_kernel(count);
    gauss_ker    = kernel;
    gauss_vec    = vector;
    for trial = 1:trial_number
        disp('Count: ')
        disp(count)
        disp('Trial: ')
        disp(trial)
        tic
        my_conv(image,gauss_ker);
        unseparated(IDX,trial) = toc;
    end
    IDX = IDX +1;
end
% save('unseparated.mat','unseparated');


%% Plot speed test
figure()
hold on;
plot(1:trial_number,separated(1,:),'-r')
plot(1:trial_number,separated(2,:),'-m')
plot(1:trial_number,separated(3,:),'-y')
plot(1:trial_number,unseparated(1,:),'-b')
plot(1:trial_number,unseparated(2,:),'-c')
plot(1:trial_number,unseparated(3,:),'-g')
title('Speed of 10 trials with kernel size 3,21,101');
legend('Separ. #3','Separ. #21','Separ. #101','Unsepar. #3','Unsepar. #21','Unsepar. #101')
hold off;

%% Show the result!

[kernel,vector] = gauss_kernel(9);
gauss_ker    = kernel;
gauss_vec    = vector;

disp('Time without seperation:')
tic
kernel_08       = my_conv(image,gauss_ker);
toc
disp('Time with seperation:')
tic
kernel_09       = my_conv(image,gauss_vec,'separate');
toc
