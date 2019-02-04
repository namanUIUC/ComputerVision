% Spring 2018 CS 543 Assignment 2
% BONUS PART
%% NAMAN SHUKLA

clear all;
clc;

% Path to the folder and subfolder
root_path = 'data/multiple/';
image_name = 'transportation/%d.jpg';              %   uttower_left
Frames = 4;
display = false;

%% IMAGE INPUT
full_path = sprintf('%s%s', root_path, image_name);
for i=1:Frames
  im{i} = imread(sprintf(full_path,i));
end

%% STITCHING
stiched = im{1};
% h = size(stiched,1);
% w = size(stiched,2);
for i=2:Frames
    stiched = stitch2img(stiched, im{i}, display);
%     stiched = imresize(stiched,[h w]);
end
% stiched = stitch2img(image1, image3, display);
% stiched = stitch2img(stiched, image2, display);
figure()
imshow(stiched)