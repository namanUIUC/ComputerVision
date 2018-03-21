%% FUNCTION TO PERFORM SCALING BY UP SAMPLING
function [mx, Filtered_img] = batch_max_preprocess(image,sigma,batch,imp)

% Create Filter
if imp == 0
    filter  = createFilter(sigma, 'log');
else
    filter  = createFilter(sigma, 'gauss');
end

% Filtered Image
Filtered_img=abs(imfilter(image, filter{1}, 'same', 'replicate'));

% Nonmax Image
mx = ordfilt2(Filtered_img,batch*batch,ones(batch,batch)); % Grey-scale dilate., taking 9 for alloting max in neighbourhood