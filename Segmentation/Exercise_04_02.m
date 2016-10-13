%% Exercise 03
% Watershed transform

clear all;
close all;

%%
img = imread('maze1.png');
laplace = [0 1 0; 1 -4 1; 0 1 0];
img_gradient = conv2(double(img),laplace);
norm_val = max(abs(min(img_gradient(:))),abs(max(img_gradient(:))));
output_image = round(floor(255/2)+((img_gradient./norm_val)*(floor(255/2))));


%%


labeled_image = zeros(size(output_image));

label_num = 1;

% 3. If h < max f(x,y) increment h, else stop.
for level = 0:255
    % 4. for all x,y: Check if h ? f(x,y) and Label(x,y) == “noLabel”
    if any(labeled_image(output_image <= level)==0)
        
        [rows,cols] = find(output_image <= level);
        
        wells(:,1) = rows;
        wells(:,2) = cols;
        
        for IDX = 1:size(wells,1)
            
% BORDER TREATMENT            
            if wells(IDX,1)==1
                if wells(IDX,2)==1
                    patch = labeled_image(wells(IDX,1):wells(IDX,1)+1,...
                                  wells(IDX,2):wells(IDX,1)+1);
                elseif wells(IDX,2)==size(labeled_image,2) 
                    patch = labeled_image(wells(IDX,1):wells(IDX,1)+1,...
                                   wells(IDX,2)-1:wells(IDX,1));
                else
                    patch = [labeled_image(wells(IDX,1):wells(IDX,1)+1,...
                                           wells(IDX,2)-1), ...
                             labeled_image(wells(IDX,1):wells(IDX,1)+1,...
                                           wells(IDX,2)), ....
                             labeled_image(wells(IDX,1):wells(IDX,1)+1,...
                                           wells(IDX,2)+1)];
                end
                
            elseif wells(IDX,1) == size(labeled_image,1)
                if wells(IDX,2) == 1
                    patch = labeled_image(wells(IDX,1)-1:wells(IDX,1),...
                                          wells(IDX,2):wells(IDX,2)+1);
                elseif wells(IDX,2) == size(labeled_image,2)
                    patch = labeled_image(wells(IDX,1)-1:wells(IDX,1),...
                                          wells(IDX,2)-1:wells(IDX,2));
                else
                    patch = [labeled_image(wells(IDX,1)-1:wells(IDX,1),...
                                           wells(IDX,2)-1),...
                             labeled_image(wells(IDX,1)-1:wells(IDX,1),...
                                           wells(IDX,2)),...
                             labeled_image(wells(IDX,1)-1:wells(IDX,1),...
                                           wells(IDX,2)+1)];
                                       
                end
            elseif wells(IDX,2) ==1
                patch = [labeled_image(wells(IDX,1)-1:wells(IDX,1)+1,...
                                       wells(IDX,2)),...
                         labeled_image(wells(IDX,1)-1:wells(IDX,1)+1,...
                                       wells(IDX,2)+1)];
            elseif wells(IDX,2) == size(labeled_image,2)
                patch = [labeled_image(wells(IDX,1)-1:wells(IDX,1)+1,...
                                       wells(IDX,2)-1),...
                         labeled_image(wells(IDX,1)-1:wells(IDX,1)+1,...
                                       wells(IDX,2))];
            else
                patch = labeled_image(wells(IDX,1)-1:wells(IDX,1)+1,...
                                      wells(IDX,2)-1:wells(IDX,1)+1);
            end
% BORDER TREATMENT

            patch = patch(:);
            
            % (x,y) is isolated, i.e., there are no neighboring “flooded”
            % pixels. (with f<h). Isolated pixels are seed points of new
            % segments
            if ~any(patch)
                labeled_image(wells(IDX,1),wells(IDX,2)) = label_num;
                label_num = label_num+1;
            
            % The neighbors of (x,y) have identical labels. Then assign
            % (x,y) to this segment [patch(find(patch)) = all non0 elems]
            elseif all(patch(find(patch))== min(patch(find(patch))))
                labeled_image(wells(IDX,1),wells(IDX,2)) = min(patch(find(patch)));
                
            % The neighbors of (x,y) have different labels. Then (x,y) is a
            % watershed
            else
                labeled_image(wells(IDX,1),wells(IDX,2)) = -1;
            end
            clearvars patch
        end
    end 
    clearvars rows cols wells 
end

labeled_image(labeled_image==-1) = 0;

subplot(1,2,1)
imshow(uint8(output_image));
subplot(1,2,2)
imshow(label2rgb(labeled_image, 'prism', 'C', 'shuffle'));
        