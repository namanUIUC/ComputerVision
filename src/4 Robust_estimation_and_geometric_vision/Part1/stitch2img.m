function stiched = stitch2img(input1, input2, display)
%% HYPERPARAMETERS

RANSAC_max_iterations = 500;
patch_size = 5;
threshold = 0.8;
bracket_cardinality = 500;
remove_border = true;

harris_sigma = 3;
harris_thresh = 0.05;
harris_radius = 3;

if display
    harris_disp = 1;
else
    harris_disp = 0;
end

%% PROCESSING IMAGE

[img_1, h_1, w_1] = processImage(input1, remove_border);
[img_2, h_2, w_2] = processImage(input2, remove_border);

%% CORNER DETECTION

[bimg_1, row_1, col_1] = harris(img_1, harris_sigma, harris_thresh, harris_radius, harris_disp);
[bimg_2, row_2, col_2] = harris(img_2, harris_sigma, harris_thresh, harris_radius, harris_disp);

%% CORNER REFINING 

[row_1, col_1, corners_1] = refineCorners(row_1, col_1, h_1, w_1, patch_size);
[row_2, col_2, corners_2] = refineCorners(row_2, col_2, h_2, w_2, patch_size);

%% PATCH FINDING

descriptor_1 = generatePatch(img_1, row_1, col_1, corners_1, patch_size);
descriptor_2 = generatePatch(img_2, row_2, col_2, corners_2, patch_size);

%% DISTANCE MATRIX

D = zeros(corners_1,corners_2);
for i = 1:corners_1
    for j = 1:corners_2
        D(i, j) = dist2(descriptor_1(i, :), descriptor_2(j, :));
    end
end

%% BEST BRACKET

bracket_cardinality = min([bracket_cardinality, corners_1, corners_2]);
bracket = [];

for i = 1:bracket_cardinality
    [r, c] = find(D == min(min(D)));
    if(length(r) == 1)
        bracket = [bracket; r, row_1(r), col_1(r), c, row_2(c), col_2(c), min(min(D))];
        D(r,:) = inf;
        D(:,c) = inf;
    end
end

%% RANSAC

[match, residual, H] = RANSAC(bracket, RANSAC_max_iterations, threshold);

%% TRANSFORMATION

stiched = transform2image(input1, input2, H);

%% DISPLAY

if display
    figure();
    imshow(img_1);
    hold on;
    scatter(bracket(:, 3),bracket(:, 2), 'y', 's');
    scatter(match(:, 3),match(:, 2), 'r', 's');
    figure();
    imshow(img_2);
    hold on;
    scatter(bracket(:, 6),bracket(:, 5), 'y', 's');
    scatter(match(:, 6),match(:, 5), 'r', 's');
    figure();
    showMatchedFeatures(input1, input2, match(:, 3:-1:2), match(:, 6:-1:5),'montage', 'PlotOptions', {'rs', 'rs', 'y-'});
end

end