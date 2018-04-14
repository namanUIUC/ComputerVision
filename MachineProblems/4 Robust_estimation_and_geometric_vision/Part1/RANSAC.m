function [match, residual, H] = RANSAC(bracket, RANSAC_max_iterations, threshold)
cutoff = 10;
bracket_cardinality = size(bracket, 1);
sample_size = 4;
match = [];
iter = 1;
while(iter < RANSAC_max_iterations)
    if sample_size == 4
        sample_indx = randsample(bracket_cardinality, sample_size);
    end
    
    H = homography(bracket, sample_size, sample_indx);
    [sample_indx, residual, inliers] = findInliers(H, bracket, bracket_cardinality, threshold);
    
    %num_of_inliers
    if(inliers >= cutoff)
        sample_size = inliers;
        iter = iter+1;
    else
        sample_size = 4;
    end
end

% mean_of_residual = mean(residual);

for i = 1:inliers
    match = [match; bracket(sample_indx(i), :)];
end

fprintf("Number of homography inliers: %d \n", inliers);
fprintf("Residual : %d \n",mean(residual));
end
