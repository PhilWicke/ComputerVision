function [ dist_img ] = img_morph( imgA,imgB,amount, varargin )
%IMG_MORPH img_morph( imgA,imgB,amount )
%   morphing beteween two images based on a distance transform
%   Inputs:     imgA = binary image to be morphed
%               imgB = binary image to be morphed
%               amount = percentage of image B in morphed result
%
%               Parameter 'all' = gives all interpolation steps
    
    % step size of distance transform
    N = 1000;
    % amount of picture one
    amount = amount*10;
    
    distA = bwdist(imgA);
    distB = bwdist(imgB);
    
    % error handling
    if size(imgA,1) ~= size(imgB,1) || size(imgA,2) ~= size(imgB,2)
        error('Images must be of equal size!');
    end
    
    % DECISION
    if ismember('all',varargin)
        dist_img = zeros(N,size(imgA,1),size(imgA,2));
        % if you need all interpolation steps, use 'all'
        for idx = 0:N
            % do the linear interpolation according to lecture
            dist_img(idx+1,:,:) = im2bw((idx*distB + (N-idx)*distA) / N);
        end
    else 
        % in regular case return the desired amount and save comp. time
        dist_img = im2bw((amount*distB + (N-amount)*distA) / N);
    end
    
end

