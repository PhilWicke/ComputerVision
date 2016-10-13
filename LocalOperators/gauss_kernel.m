function [ kernel, vector ] = gauss_kernel( kernel_size )
%GAUSS_KERNEL Summary of this function goes here
%   Detailed explanation goes here

    n = kernel_size-1;
    vector = zeros(size(n));
    for k = 0:n
        vector(k+1) = nchoosek(n,k);
    end
    coeff  = sum(vector);
    vector = vector/coeff;
    
    kernel = (vector' * vector);
end

