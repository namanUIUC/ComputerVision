%% Spring 2014 CS 543 Assignment 1
%% Arun Mallya and Svetlana Lazebnik
clear all
clc
% path to the folder and subfolder
root_path = 'croppedyale/';
subject_name = 'yaleB07';

integration_method = 'random'; % 'column', 'row', 'average', 'random'

save_flag = 0; % whether to save output images
displayall = 1; %whether to display all images
subsam = 0; %To subsample based on thersholding
filt = 1; % filtered image 0-no filtering 1-gaussian 2-sharp

%% load images
full_path = sprintf('%s%s/', root_path, subject_name);
[ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, subject_name, 64);
image_size = size(ambient_image);


%% preprocess the data: 
%% subtract ambient_image from each image in imarray
%% make sure no pixel is less than zero
%% rescale values in imarray to be between 0 and 1
%% <<< fill in your preprocessing code here >>>
imarray = bsxfun(@minus, imarray, ambient_image);
%processed = max(0, processed);
imarray(imarray<0) = 0;
%processed = bsxfun(@rdivide, processed, max(processed(:)));
imarray = bsxfun(@rdivide, imarray, max(max(imarray)));

if subsam
    threshold = 0.30;
    [imarray, light_dirs] = sub_sample(imarray, light_dirs, threshold, filt);
end

%% get albedo and surface normals (you need to fill in photometric_stereo)
[albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs);

%% reconstruct height map (you need to fill in get_surface for different integration methods)
height_map = get_surface(surface_normals, image_size, integration_method);

%% display albedo and surface
display_output((albedo_image), height_map);

%% plot surface normal
plot_surface_normals(surface_normals);

%% save output (optional) -- note that negative values in the normal images will not save correctly!
if save_flag
    imwrite(albedo_image, sprintf('%s_albedo.jpg', subject_name), 'jpg');
    imwrite(surface_normals, sprintf('%s_normals_color.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,1), sprintf('%s_normals_x.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,2), sprintf('%s_normals_y.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,3), sprintf('%s_normals_z.jpg', subject_name), 'jpg');    
end

if displayall
    for i=1:size(imarray,3)
        subplot(8,8,i), imshow(imarray(:,:,i))
    end
end

