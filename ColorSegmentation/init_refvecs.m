function [ ref_vecs ] = init_refvecs( input_image, num )
%INIT_REFVECS init_refvecs( input_image, num )
%   Initializes random cluster points in the image color space 
% 
%   Input:      input_image = the image space you want to cluster
%               num         = the number of initial reference vectors
    
    % Allocate space for reference vectors
    ref_vecs = zeros(num,3);
    for IDX = 1:num
        % sample out of image space with 3 samples -> RGB
        % TODO: Improve to sample out of each dimension seperatly
        %       this is just pseudo-random
        ref_vecs(IDX,:) = randsample(input_image(:),3);
    end
    
end

