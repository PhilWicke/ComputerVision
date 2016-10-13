%% Exercise 07.02 - My Fourier Transform
% fwalocha, pwicke

clear vars;
close all;
clc;

L = 100;
X = 1:L;

figure;
hold on;
%plot(1:L,funcs(L,1),'b-');
plot(X,fft(funcs(L,2)));
%plot(X,my_ft(X,funcs(L,2),L));

