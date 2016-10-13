%% Exercise 02
% fwalocha, pwicke

clear all;
close all;

%% 
img = imread('hiwCz.png');
hsv=1;


if hsv == 1
    img = rgb2hsv(img);
else
    img = double(img);
end


%%

img_x = reshape(img,[size(img,1)*size(img,2),size(img,3)]);

if hsv ==1
    hue = img_x(:,1);
    hue = (2*pi) *hue;
    saturation = img_x(:,2);
    value =img_x(:,3);

    X = zeros(size(img_x,1),1);
    Y = zeros(size(img_x,1),1);
    
    for IDX = 1:size(img_x,1)
        X(IDX) = cos(hue(IDX))*saturation(IDX)*value(IDX);
        Y(IDX) = sin(hue(IDX))*saturation(IDX)*value(IDX);
    end

    Z = value;
    X = (X+value)/2+(1-value)*0.5;
    Y = (Y+value)/2+(1-value)*0.5;
    
    img_x(:,1) = X;
    img_x(:,2) = Y;
    img_x(:,3) = Z;
    
end

%%

indices = randsample(1:size(img_x,1),3);
ref_vec = [img_x(indices(1),:);img_x(indices(2),:);img_x(indices(3),:)];


if hsv==1
    threshold = 0.3;
else
    threshold = 10;
end

devs = [100 100 100];

while max(devs)>=threshold || any(any(isnan(ref_vec)))
    
    if any(any(isnan(ref_vec)))
        indices = randsample(1:size(img_x,1),length(find(isnan(ref_vec))));
        ref_vec(find(isnan(ref_vec))) = img_x(indices);
    end
    
    dist1 = pdist_kmeans(ref_vec(1,:),img_x);
    dist2 = pdist_kmeans(ref_vec(2,:),img_x);
    dist3 = pdist_kmeans(ref_vec(3,:),img_x);

    clust_ref = zeros(size(dist1,1),1);

    for IDX = 1:size(dist1)
       [mini, index] = min([dist1(IDX),dist2(IDX),dist3(IDX)]);
       clust_ref(IDX) = index;
    end

    vals = zeros(3,3);
    devs = zeros(3,1);
    for RFS = 1:size(ref_vec,1)
        mask = clust_ref==RFS;
        vals(1,RFS) = mean(img_x(find(mask),1));
        vals(2,RFS) = mean(img_x(find(mask),2));
        vals(3,RFS) = mean(img_x(find(mask),3));

        devs(RFS) = pdist([ref_vec(:,RFS)';vals(:,RFS)']);
    end
    devs
    ref_vec = vals;
end

%%

cols = zeros(size(clust_ref,1),3);
for RFS = 1:size(ref_vec,1)
    mask = clust_ref==RFS;
    colors = rand(3,1)';
    cols(find(mask),:) = repmat(colors(1,:),size(cols(find(mask),:),1),1); 

end

%%

figure
scatter3(img_x(:,1),img_x(:,2),img_x(:,3),1,cols);
