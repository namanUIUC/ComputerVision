function [ bestF, inlierIndices] = RANSAC(matches, maxIterRANSAC, Normalize)

    sample_size = 8;
    Threshold = 35;
    minInlier = 8;
    N = size(matches, 1);
    numInliersEachIteration = zeros(maxIterRANSAC,1);
    storedF = {};
    
    for i = 1 : maxIterRANSAC     

        sample_indx = randsample(N, sample_size);
        matches_subset = matches(sample_indx, :);
            

        F = fit_fundamental(matches_subset, Normalize);
        

        L = (F * [matches(:,1:2) ones(N,1)]')';
        L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
        residualErrors = abs(sum(L .* [matches(:,3:4) ones(N,1)],2));
        
        

        inlierIndices = find(residualErrors < Threshold);      


        numInliersEachIteration(i) = length(inlierIndices);
        

        currentInlier = numInliersEachIteration(i);
        if currentInlier >=  minInlier

            matches_inliers = matches(inlierIndices, :);
            storedF{i} = fit_fundamental(matches_inliers, Normalize);
        end
    end

    
    
    bestIter = find(numInliersEachIteration == max(numInliersEachIteration));
    if (size(bestIter,1) > 1)
        bestIter = bestIter(1); 
    end
    bestF = storedF{bestIter};
    

    L = (bestF * [matches(:,1:2) ones(N,1)]')';
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
    residualErrors = abs(sum(L .* [matches(:,3:4) ones(N,1)],2));
    inlierIndices = find(residualErrors < Threshold);
end
