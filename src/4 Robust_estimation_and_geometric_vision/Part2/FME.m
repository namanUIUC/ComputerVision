function [F, residuals]=FME( I1, I2, matches, mode, display)

%% PARAMETERS 
Normalize = true;
putative = true;
N = size(matches,1);

%% VISUALIZATION
if(display)
    visualize(I1,I2,matches);
end

%% FUNDAMENTAL MATRIX USING THE MATCHES
switch mode
    case 'TrueFit'
        F = fit_fundamental(matches, Normalize);
        
    case 'RANSAC'
        if (putative)
            points1 = detectHarrisFeatures(im2double(rgb2gray(I1)));
            points2 = detectHarrisFeatures(im2double(rgb2gray(I2)));
            [features1, valid_points1] = extractFeatures(im2double(rgb2gray(I1)), points1);
            [features2, valid_points2] = extractFeatures(im2double(rgb2gray(I2)), points2);
            % Match the features.
            
            indexPairs = matchFeatures(features1,features2);
            % Retrieve the locations of the corresponding points for each image.
            
            matchedPoints1 = valid_points1(indexPairs(:,1),:);
            matchedPoints2 = valid_points2(indexPairs(:,2),:);
            % matchedPoints1.Location
            matches = [matchedPoints1.Location matchedPoints2.Location];
            
        end
        [F, matches] = estimate_fundamental(matches, Normalize);
        N = size(matches,1);
    otherwise
        display('Please enter a valid mode');
        return
end

%% EPIPOLAR LINES ON SECON IMAGE REPROJECTED FROM FIRST IMAGE
L = (F * [matches(:,1:2) ones(N,1)]')'; 
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; 
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

figure;
imshow(I2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');
hold on; 
title('Epipolar Lines');

%% RESIDUALS IN THE ESTIMATION
distances = sum(L .* [matches(:,3:4) ones(N,1)],2);
residuals = abs(distances);

end