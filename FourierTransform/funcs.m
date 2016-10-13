function [ Y ] = funcs( L, nr)
%FUNC01 Summary of this function goes here
%   Detailed explanation goes here
    
    switch nr
        
        case 1
            Y = sin(2*pi*(1:L)/L);
        case 2
            if L < 60
                error('For this function, L must be >=60.');
            end
            Y = zeros(1,L); 
            Y(40:60) = 1;
        case 3
            Y = gausswin(L,1./0.1);
    end
            
end

