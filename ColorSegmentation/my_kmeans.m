function [ clust_ref ] = my_kmeans( input_image, cluster_num, epsilon, varargin)
%KMEANSRGB Summary of this function goes here
%   Detailed explanation goes here
    
    % treat input
    img = input_image;
       
    % to compare all values in the image, first concat all x,y values
    img_x = reshape(img,[size(img,1)*size(img,2),size(img,3)]);

    % initialize random reference vectors and check for empty vectors
    if isempty(varargin)
       ref_vecs = init_refvecs(img,cluster_num);
    else
       ref_vecs = varargin{1};
       if any(any(isnan(ref_vecs)))
           indices = randsample(1:size(img_x,1),length(find(isnan(ref_vecs))));
           ref_vecs(find(isnan(ref_vecs))) = img_x(indices);
       end
    end
    

    % dist holds all distances from points to reference vectors
    dist = zeros(cluster_num,size(img_x,1));
    for IDX = 1:size(ref_vecs,1)
        dist(IDX,:) = pdist_kmeans(ref_vecs(IDX,:),img_x);
    end

    % assign each point to a cluster according to its minimal distance
    clust_ref = zeros(size(dist,2),1);
    for IDXpoint = 1:size(dist,2)
       [mini, index] = min(dist(:,IDXpoint));
       clust_ref(IDXpoint) = index;
    end

    % Transform the obtained classification into a mask format to fit image
    % clust_mask = reshape(clust_ref,[size(img,1),size(img,2)]);
    
    % Get the mean of all values assigned to a cluster
    new_refs = zeros(size(ref_vecs));
    for IDXclust = 1:cluster_num
        mask = clust_ref==IDXclust;
        new_refs(IDXclust,:) = mean(img_x(find(mask),:));
    end

    % get the euclidean distance between the old reference vectors and the
    % new reference vectors
    devs = zeros(1,cluster_num);
    for IDX1 = 1:cluster_num
        devs(IDX1) = pdist([ref_vecs(IDX1,:);new_refs(IDX1,:)]);
    end
    
    if (max(devs) >= epsilon)
        disp('Devs: ');
        disp(devs);
        clust_ref = my_kmeans(input_image,cluster_num,epsilon,new_refs);
    end
    
end

