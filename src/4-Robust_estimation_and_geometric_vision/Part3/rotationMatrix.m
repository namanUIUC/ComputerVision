function R = rotationMatrix(processed, K)

    vpx = processed(1,:);
    vpy = processed(2,:);
    vpz = processed(3,:);
    
    X = inv(K)*vpx';
    Y = inv(K)*vpy';
    Z = inv(K)*vpz';
    
    R = [(X/sqrt(sumsqr(X))), (Y/sqrt(sumsqr(Y))),(Z/sqrt(sumsqr(Z)))];
    
end