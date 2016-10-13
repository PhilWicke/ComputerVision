function [ output_image ] = my_conv( input_image, kernelORvec, varargin )
%MY_CONV my_conv( input_image, kernelORvec, varargin )
%   If used with SEPARATE version, you must provide a vector to sustain
%   comparability between the evaluation.
%
%   Inputs: input_image = the image you want to apply the convolution on to
%           kernelORvec = this is the kernel you want to use for the
%           convolution. In order to compare the speed of separation vs
%           non-separation, the derivation of the vector out of the kernel
%           must be provided prior entering it, therefore if you want to
%           use the 'separate' argument, provide a vector not a kernel.
%           kernel must have odd lengths, because this enables to choose a
%           centre point.
%           varargin = takes multiple parameters:
%                    'border' = will open option menu for border treatment
%                   'separate'= a gaussian kernel can be separated, such
%                               that convolution is applied separately and
%                               after that, the product of vectors is taken
%                               GAUSSIAN ONLY!
%                   'min'     = will apply the minimum-kernel algorithm
%                   'max'     = will apply the maximum-kernel algorithm
%                   'median'  = pixel is evaluated by the kernel median
%                   'snn'     = will apply the symmetric nearest neighbour
%                               algorithm
%                   'dilate'  = allows to do dilation with the image
%                   'erode'   = allows to do erosion with the image


    % input handling
    if mod(size(kernelORvec,1),2)==0 || mod(size(kernelORvec,2),2)==0
        error('Input kernel must have odd lengths')
    end
    
    % Cast onto double to avoid side effects
    input_image = double(input_image);
    
    % check if separation is requested
    separate = false;
    if ismember('separate', varargin) 
        separate = true;
        
    % get appropriate kernel expansion from center to define patch
    % so to say the thickness around the centre of the kernel
    
        % Deal with vectors: 3x1 chose 3 for expansion.
        [ker_expY, ker_expX] = deal(max(floor(size(kernelORvec,1)/2), ... 
                                    floor(size(kernelORvec,2)/2)));
    
    else % Deal with kernels: 5x3 chose 5 and 3 for expansion.
        ker_expY = floor(size(kernelORvec,1)/2);
        ker_expX = floor(size(kernelORvec,2)/2);
    end
    
    % get values
    y_axis = size(input_image,1);
    x_axis = size(input_image,2);
            
    % handle argument for border padding and embed input_image 
    if ismember('border', varargin)
        
        choice = questdlg('Corner treatment', ...
                          'Choose an option', ... 
                          'Black colored rim', ...
                          'Multi-Image Rim', ...
                          'Mirrored Rim', ...
                          'Mirrored Rim'); 
        
        % Allocate space
        input_padded = zeros(size(input_image,1)+2*ker_expY, ... 
                             size(input_image,2)+2*ker_expX);

        % Get positions for multipic and mirrorpic option
        Ypos1 = 1:y_axis;
        Ypos2 = (y_axis+1):(2*y_axis);
        Ypos3 = ((2*y_axis)+1):(3*y_axis);

        Xpos1 = 1:x_axis;
        Xpos2 = (x_axis+1):(2*x_axis);
        Xpos3 = ((2*x_axis)+1):(3*x_axis);
                         
        switch choice
            % Use 0val rim
            case 'Black colored rim'
                input_padded(ker_expY+1:end-ker_expY, ...
                         ker_expX+1:end-ker_expX)         = input_image;        
                input_image = input_padded;
                
                clearvars input_padded;
        
            % Copy-Paste image rim
            case 'Multi-Image Rim'
                % Allocate Space
                pic_pic = zeros(3*y_axis,3*x_axis);
                     
                % Distribute picture onto 9 positions
                [pic_pic(Ypos1,Xpos1),...
                 pic_pic(Ypos1,Xpos2),...
                 pic_pic(Ypos1,Xpos3),...
                 pic_pic(Ypos2,Xpos1),...
                 pic_pic(Ypos2,Xpos2),...
                 pic_pic(Ypos2,Xpos3),...
                 pic_pic(Ypos3,Xpos1),...
                 pic_pic(Ypos3,Xpos2),...
                 pic_pic(Ypos3,Xpos3)] = deal(input_image);

                input_padded = pic_pic((y_axis+1-ker_expY):(end-y_axis+ker_expY), ...
                    (x_axis+1-ker_expX):(end-x_axis+ker_expX));
                input_image = input_padded;
                
                clearvars pic_pic input_padded

            %Copy-Paste mirrored image rim
            case 'Mirrored Rim'
                % Allocate space
                pic_mirr = zeros(3*y_axis,3*x_axis);
                
                %4 corners
                [pic_mirr(Ypos1,Xpos1), pic_mirr(Ypos3,Xpos1),...
                 pic_mirr(Ypos1,Xpos3), pic_mirr(Ypos3,Xpos3)]= ...
                    deal(input_image(end:-1:1,end:-1:1));
                %Left and right border
                [pic_mirr(Ypos2,Xpos1), pic_mirr(Ypos2,Xpos3)]     = ...
                    deal(input_image(:,end:-1:1));
                %Upper and lower border
                [pic_mirr(Ypos1,Xpos2), pic_mirr(Ypos3,Xpos2)]     = ...
                    deal(input_image(end:-1:1,:));
                %Actual image
                pic_mirr(Ypos2,Xpos2)                                  = ...
                    input_image;

                input_padded = pic_mirr((y_axis+1-ker_expY):(end-y_axis+ker_expY), ...
                    (x_axis+1-ker_expX):(end-x_axis+ker_expX));
                input_image = input_padded;
                
                clearvars pic_mirr input_padded
                
        end
    end
    
    % allocating output
    output_image = input_image;

    % iterate +1 step from corners away through entire image
    for IDXy = ker_expY +1 : y_axis - ker_expY
        for IDXx = ker_expX +1 : x_axis - ker_expX
            % add the desired expansion range of the kernel to the patch
            patch = input_image(IDXy-ker_expY:IDXy+ker_expY, ...
                                IDXx-ker_expX:IDXx+ker_expX);
            
            % handle the different parameters and apply demanded algorithm
            % EROSION
            if ismember('erode',varargin)
                output_image(IDXy,IDXx) = any(patch(:));
            % DILATION
            elseif ismember('dilate',varargin)
                output_image(IDXy,IDXx) = all(patch(:));
            % MIN
            elseif ismember('min',varargin)
                output_image(IDXy,IDXx) = min(patch(:));
            % MAX
            elseif ismember('max',varargin)
                output_image(IDXy,IDXx) = max(patch(:));
            % MEDIAN
            elseif ismember('median', varargin)
                sort_patch = sort(patch(:));
                medianIDX  = round(size(sort_patch(:),1)/2);
                output_image(IDXy,IDXx) = sort_patch(medianIDX);
            % SYMMETRIC NEAREST NEIGHBOUR
            elseif ismember('snn', varargin)
                patch     = patch(:);
                sort_patch= sort(patch);
                patch_len = size(sort_patch(:),1);
                matcher   = round(patch_len/2);
                pairs     = zeros(matcher-1,1);
                
                for IDX = 1:matcher-1
                    val01 = patch(IDX);
                    val02 = patch(patch_len-(IDX-1));
                    if abs(matcher - val01) <= abs(matcher - val02)
                        pairs(IDX) = val01;
                    else
                        pairs(IDX) = val02;
                    end
                    output_image(IDXy,IDXx) = mean(pairs);
                end
            % SEPARATION
            elseif separate 
                output_image(IDXy,IDXx) = patchKernel(patch, kernelORvec, 'separate');
            % DEFAULT
            else
                output_image(IDXy,IDXx) = patchKernel(patch, kernelORvec); 
            end
        end
    end
    
    if ismember('border', varargin)
        output_image = output_image(ker_expY+1:end-ker_expY, ... 
                                    ker_expX+1:end-ker_expX);
    end
 
    % laplace has a negative value in the kernel, we deal with it here
    if ismember('laplace',varargin)
        disp('Laplace detected')
        norm_val = max(abs(output_image(:)));

        % ask for threshold
        threshold = -1;
        while (threshold > 1) || (threshold < 0)
            prompt = 'Please enter a threshold between 0 and 1';
            threshold = inputdlg(prompt,'Laplace Operation');
            threshold = str2double(cell2mat(threshold)); % python:matlab = 2:0!
        end
        % all values below thershold percentage of max value kicked out 
        mask = abs(output_image)>(threshold*norm_val);
        output_image = output_image.*mask; 
      
        % normalise to values between medium gray value and 255
        output_image = floor(255/2)+((output_image./norm_val)*(floor(255/2)));
    end
    
    % transform image  to uint8
    output_image = uint8(output_image);
    
end

