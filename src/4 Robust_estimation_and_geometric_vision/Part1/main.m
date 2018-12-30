% Spring 2018 CS 543 Assignment 3
% Part 1
%% NAMAN SHUKLA

clear all;
clc;

% Path to the folder and subfolder
root_path = 'data/couple/';
image_name_1 = 'uttower_left.jpg';       
image_name_2 = 'uttower_right.jpg';                
display = true;

%% IMAGE INPUT
full_path1 = sprintf('%s%s', root_path, image_name_1);
image1 = imread(full_path1);
full_path2 = sprintf('%s%s', root_path, image_name_2);
image2 = imread(full_path2);


%% STITCHING
stiched = stitch2img(image1, image2, display);
figure()
imshow(stiched)