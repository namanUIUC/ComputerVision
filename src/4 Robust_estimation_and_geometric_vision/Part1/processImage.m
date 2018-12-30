function [img, h, w] = processImage(image, remove_border)

img = rgb2gray(image);
img = im2double(img);
[h, w] = size(img);
if (remove_border)
    img(:, 1) = img(:, 2);
    img(:, w) = img(:, w-1);
    img(1, :) = img(2, :);
    img(h, :) = img(h-1, :);
end
end