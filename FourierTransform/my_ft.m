function [ C ] = my_ft(X,Y,L)
%MY_FT Summary of this function goes here
%   Detailed explanation goes here
    
    C = sum(Y.*exp(((2*pi*1i)/L)*X));
    
end

