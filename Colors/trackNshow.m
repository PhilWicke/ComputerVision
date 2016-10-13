function [ marked_img, value ] = trackNshow(input_img, func, threshold, varargin) 
%DONSHOW Exists solely to reuse camera_loop for Ex1
%   Builds a bridge so I don't have to rewrite camera_loop on a sunday..

% ignore this
value = 0;

marked_img = func(input_img, threshold, varargin{:});

imshow(marked_img);

end

