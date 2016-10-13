function new_probs = updt_probs( probs )
% UPDATE_PROBABILITIES Initialize relaxation labeling .
% [ NEW_PROBS CHANGE ] = UPDATE_PROBABILITIES ( PROBS )
% Update the probability values using the formulae from the
% lecture . NEW_PROBS are the updated label probabilities .


% Variables
y_axis  = size(probs,1);
x_axis  = size(probs,2);
N       = size(probs,3);

for IDXlabA = 1:N
    for IDXyA = 2:y_axis-1
        for IDXxA = 2:x_axis-1
            
            % the compatibility factor is 0 only if it is compared to
            % another pixel that is part of another label
            

            
            
            
            
            for IDXlabB = 1:N
                for IDXyB = 2:y_axis-1
                    for IDXxB = 2:x_axis-1
                        if IDXxA == IDXxB || IDXyA == IDXyA
                            break;
                        else
                            r = IDXlabA == IDXlabB;
                            probpixel = probs(IDXyA,IDXxA,IDXlabA);
                            q = sum(probpixel * r);
                            
                            % Checking 8-neighbourhood
                            check = probs(IDXyA,IDXxA,IDXlabA);
                            c =(check == probs(IDXyB-1,IDXxB,IDXlabA)...
                            || check == probs(IDXyB-1,IDXxB-1,IDXlabA)...
                            || check == probs(IDXyB,IDXxB-1,IDXlabA)...
                            || chech == probs(IDXyB+1,IDXxB,IDXlabA)...
                            || check == probs(IDXyB+1,IDXxB+1,IDXlabA)...
                            || check == probs(IDXyB,IDXxB+1,IDXlabA)...
                            || check == probs(IDXyB+1,IDXxB-1,IDXlabA)...
                            || check == probs(IDXyB-1,IDXxB+1,IDXlabA));
                            c = c*(1/8); 
                            
                            Q(ID = sum(c * q);
                        end
                    end
                end
                
            end
        end
    end
end


end