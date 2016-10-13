function [ distances ] = pdist_kmeans( ref_vec, points )
%PDIST_KMEANS pdist_kmeans( ref_vec, points )
%   calculates the pairwise distance between reference points and given
%   points of the space

distances = zeros(size(points,1),1);

for IDX = 1:size(points,1)
    test_vec = [ref_vec;points(IDX,1),points(IDX,2),points(IDX,3)];
    distances(IDX) = pdist(double(test_vec));
end

end

