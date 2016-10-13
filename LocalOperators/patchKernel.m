function [ output_pixel ] = patchKernel( patch, kernelORvec, varargin)
%PATCHKERNEL a function that applies an (2m + 1) × (2n + 1)-kernel to an
%   image patch of the same size, using the convolution formula from
%   the lecture.
%
%   Inputs: input_patch = the image patch you want to convolute over
%
%Example:       ( 1  2  1 )                 ( 1 )
%           k = ( 2  4  2 )  =  (1  2  1) * ( 2 )  = n*m
%               ( 1  2  1 )                 ( 1 ) 
%
% Patch x k(ernel) runs in O(n*m), whereas 
% column(patch)*n + row(patch)*m runs in O(n+m)
%
% Kernel is defined by Pascals Pyramid:
%                       1
%                     1 2 1 and so on...
% We can use (n chose k) for that with Kernel = rows(N chose #column)
    

        % seperated version
    if ismember('separate',varargin)
        % use separated vector to convolute in O(n+m)
        output_pixel = (kernelORvec*patch)*kernelORvec';
    else
        % regular convolution
        output_pixel = sum(sum(patch.*kernelORvec));
    end


end

