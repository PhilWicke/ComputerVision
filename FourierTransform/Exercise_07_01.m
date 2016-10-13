%% Exercise 07.01 - Understanding Fourier Transform
% pwicke, fwalocha

clear all;
close all;
clc;

% Transform the image dolly.png into the frequency space 
% (you may use the Matlab function fft2). 
% The result will be a complex matrix. Plot histograms for
% the amplitude and phase values.

img         = imread('dolly.png');
fft_img     = fft2(double(img));

subplot(1,2,1)
hist(log(abs(fftshift(fft_img))))
title('log Amplitude');

subplot(1,2,2)
hist(angle(fftshift(fft_img)))
ylim([60 100])
title('Phase');

% Display the amplitude and phase in separate images. 
% You may again take the logarithm of the amplitude to enhance the contrast.
% You may also center the base frequency (see Matlab function fftshift)

figure
imshow(abs(fftshift(fft_img)),[24 100000])
colormap gray
title('Image FFT2 Magnitude')

figure 
imshow(angle(fftshift(fft_img)),[-pi pi])
colormap gray
title('Image FFT2 Phase')

% Transform the image back from the frequency space to the image space
% (again using fft2). What do you observe? Explain and repair the result.

ifft01_img   = ifft2(fft2(img));
figure
imshow(uint8(ifft01_img));

% Access amplitude and phase
ampl    = abs(fft2(img));
phase   = angle(fft2(img));

% restoring original image (need to call uint8() for imshow)
restore = ifft2(ampl .* exp(i*phase));

% Fix amplitude change phase
figure;
subplot(2,2,1)
imshow(uint8(ifft2(ampl .* exp(i*phase))));
title('Original');
subplot(2,2,2)
imshow(uint8(ifft2(ampl .* exp(i*(pi*phase)))));
title('Phase*Pi');
subplot(2,2,3)
imshow(uint8(ifft2(ampl .* exp(i*(0)))));
title('No Phase');
subplot(2,2,4)
imshow(uint8(ifft2(ampl .* exp(i*(phase+(pi*randn(size(img))))))));
title('Gauss Noise');

% Fix amplitude change phase
figure;
subplot(2,2,1)
imshow(uint8(ifft2(ampl .* exp(i*phase))));
title('Original');
subplot(2,2,2)
imshow(uint8(ifft2(pi*ampl .* exp(i*(phase)))));
title('Amplitude*Pi');
subplot(2,2,3)
imshow(uint8(ifft2((randn(size(img)).*ampl) .* exp(i*(phase)))));
title('Changed Amplitude');
subplot(2,2,4)
imshow(uint8(ifft2( ((pi*randn(size(img))).*ampl) .* exp(i*(phase)))));
title('Gauss Noise');
