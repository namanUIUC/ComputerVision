%% FUNCTION TO PERFORM SCALING BY DOWN SAMPLING
function [mx, Filtered_img] = image_py_preprocess(image,sigma,batch,i,k, imp)

% Create Filter
if imp == 0
    filter  = createFilter(sigma, 'log');
else
    filter  = createFilter(sigma, 'gauss');
end

% Reduced image
image_temp = imresize(image, 1/k^(i-1), 'cubic');
temp = abs(imfilter(image_temp, filter{1},'same', 'replicate'));

% Filtered Image
Filtered_img = imresize(temp, size(image), 'cubic');

% Nonmax Image
mx = ordfilt2(Filtered_img,batch*batch,ones(batch));