function [ val ] = compat( pixel01, label01, pixel02, label02 )
%COMPAT Summary of this function goes here
%   Let the compatibility of pixel pi with label lk and pixel pj with
%   label ll be defined in this function, That is, only identical labels
%   support each other and there is no explicit dependency on the pixels
val = label01 == label02;

end

