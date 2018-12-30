function [I, residual, count] = findInliers(H, bracket, bracket_cardinality, threshold)
count = 0;
I = [];
residual = [];
for i = 1:bracket_cardinality
    homogenousVector_i =  H'* [bracket(i, 3); bracket(i, 2); 1];
      
    % converting from homogenous to image coordinate
    xi = homogenousVector_i(1)/homogenousVector_i(3);
    yi = homogenousVector_i(2)/homogenousVector_i(3);
    
    Vector_i = [xi, yi];
    Vector_j = [bracket(i, 6),bracket(i, 5)];
    
    if(dist2(Vector_i, Vector_j) < threshold)
        I = [I; i];
        residual = [residual; dist2(Vector_i, Vector_j)];
        count = count+1;
    end
end
end