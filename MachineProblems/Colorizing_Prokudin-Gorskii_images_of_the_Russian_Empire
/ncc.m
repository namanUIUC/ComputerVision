function [output] = ncc(template,A)
% This function is for calculating SSD
max_val = -inf;

%Vectorize & Normalizethe Image Matrix
vector_A = reshape(A, 1, []);
normalized_A = vector_A/norm(vector_A);

for xi = -15:15
    for yi = -15:15
        
        %Move Foreground Image
        Shifted_template = circshift(template,[xi yi]);
        
        %Vectorize & Normalizethe Image Matrix
        vector_ST = reshape(Shifted_template, 1, []);
        normalized_ST = vector_ST/norm(vector_ST);
        
        %Calculate the value of NCC
        CC = dot(normalized_A,normalized_ST);
        
        if CC > max_val
            max_val = CC;
            best = [xi yi];
        end
    end
end
output = circshift(template,best);
end