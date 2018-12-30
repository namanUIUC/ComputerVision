% Spring 2018 CS 543 Assignment 2
% Part 2
%% NAMAN SHUKLA

clear all;
clc;

% Path to the folder and subfolder
root_path = 'data/';
image_name_1 = 'library1.jpg';           
image_name_2 = 'library2.jpg'; 
camera_1 = 'library1_camera.txt';
camera_2 = 'library2_camera.txt';
data = 'library_matches.txt';
mode = 'RANSAC';
display = true;


%% IMAGE AND DATA INPUT
full_path1 = sprintf('%s%s', root_path, image_name_1);
image1 = imread(full_path1);
full_path2 = sprintf('%s%s', root_path, image_name_2);
image2 = imread(full_path2);
full_path_data = sprintf('%s%s', root_path, data);
matches = load(full_path_data);
full_path_camera_1 = sprintf('%s%s', root_path, camera_1);
Cameramatrix1 = load(full_path_camera_1);
full_path_camera_2 = sprintf('%s%s', root_path, camera_2);
Cameramatrix2 = load(full_path_camera_2);


%% FUNDAMENTAL MATRIX ESTIMATION
% % [F, residuals] = FME(image1, image2, matches, mode, display);
% % fprintf('The Mean residual for %s mode: %s \n',mode,num2str(mean(residuals)));


%% TRIANGULATION
[residual1, residual2] = Triangulation( Cameramatrix1, Cameramatrix2, matches, display);
fprintf('The Mean residual for triangulation 1: %s \n',num2str(residual1));
fprintf('The Mean residual for triangulation 2: %s \n',num2str(residual2));





