function [ F , matches] = estimate_fundamental( matches, Normalize)

    maxIterRANSAC = 1000;
    
    [F, inlierIndices] = RANSAC(matches, maxIterRANSAC, Normalize);
    matches = matches(inlierIndices,:);
    L = (F * [matches(:,1:2) ones(length(inlierIndices),1)]')';
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
    residualErrors = abs(sum(L .* [matches(:,3:4) ones(length(inlierIndices),1)],2));
    
    fprintf('Number of inliers in RANSAC for F is : %s \n', num2str(length(inlierIndices)));
    fprintf('Mean Residual of Inliers in RANSAC for F is: %s \n', num2str(mean(residualErrors)));
    
end