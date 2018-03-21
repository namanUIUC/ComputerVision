%% ASSIGNMENT 0 COMPUTER VISION CS 543  || Naman Shukla
% This program will produce 15 sets of images for each 
% input image. Here is the distribution of those images:
% --output--
% Checking RGB channels : 6 Images
% Sum of squared difference (SSD) method : 3 Images
% Normalized Cross Correlation (NCC) method : 3 Images
% Pyramidal (Bonus) : 3 Images

%% Preprocessing 
clear all;
clc; 

% Input file
% imname = '00125v.jpg';
% imname = '00149v.jpg';
% imname = '00153v.jpg';
% imname = '00351v.jpg';
% imname = '00398v.jpg';
% imname = '01112v.jpg';

% imname = '01047u.tif';
% imname = '01657u.tif';
 imname = '01861a.tif';

% read in the glass plate input image
fullim = imread(imname);

% convert to double matrix 
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% divide the input image into three color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

%% Checking RGB channels

% Simple Stacking of the Images with different combinations 
RGB = cat(3,R,G,B);
imwrite(RGB,'00149v_unaligned_RGB.jpg');

RBG = cat(3,R,B,G);
imwrite(RBG,'00149v_unaligned_RBG.jpg');

GBR = cat(3,G,B,R);
imwrite(GBR,'00149v_unaligned_GBR.jpg');

GRB = cat(3,G,R,B);
imwrite(GRB,'00149v_unaligned_GRB.jpg');

BRG = cat(3,B,R,G);
imwrite(BRG,'00149v_unaligned_BRG.jpg');

BGR = cat(3,B,G,R);
imwrite(BGR,'00149v_unaligned_BGR.jpg');

%% Sum of squared difference (SSD) method
% Precentage for the cropping the border
p = 0.08;

%Base as R
alignedB = alignImage(B,R,15,p);
alignedG = alignImage(G,R,15,p);
alignedRGB = cat(3,R,alignedG,alignedB);
imwrite(alignedRGB,'00149v_aligned_ssd_baseR.jpg');

%Base as G
alignedB = alignImage(B,G,15,p);
alignedR = alignImage(R,G,15,p);
alignedRGB = cat(3,alignedR,G,alignedB);
imwrite(alignedRGB,'00149v_aligned_ssd_baseG.jpg');

%Base as B

alignedG = alignImage(G,B,15,p);
alignedR = alignImage(R,B,15,p);
alignedRGB = cat(3,alignedR,alignedG,B);
imwrite(alignedRGB,'00149v_aligned_ssd_baseB.jpg');

%% Normalized Cross Correlation (NCC) method

%Base as R
nccG = ncc(G,R);
nccB = ncc(B,R);
nccRGB = cat(3,R,nccG,nccB);
imwrite(nccRGB,'00398v_aligned_ncc_baseR.jpg');

%Base as G
nccR = ncc(R,G);
nccB = ncc(B,G);
nccRGB = cat(3,nccR,G,nccB);
imwrite(nccRGB,'00398v_aligned_ncc_baseG.jpg');

%Base as B
nccG = ncc(G,B);
nccR = ncc(R,B);
nccRGB = cat(3,nccR,nccG,B);
imwrite(nccRGB,'00398v_aligned_ncc_baseB.jpg');


%% Pyramidal (Bonus)

% Base as R 
Py_G_shift = findShift_Py(G, R, 3);
Py_B_shift = findShift_Py(B, R, 3);
PyG = circshift(G, Py_G_shift);
PyB = circshift(B, Py_B_shift);
im = cat(3,R,PyG,PyB);
imwrite(im, '01657u_aligned_pyramidal_baseR.jpg')

% Base as G 
Py_R_shift = findShift_Py(R, G, 3);
Py_B_shift = findShift_Py(B, G, 3);
PyR = circshift(R, Py_R_shift);
PyB = circshift(B, Py_B_shift);
im = cat(3,PyR,G,PyB);
imwrite(im, '01657u_aligned_pyramidal_baseG.jpg')

% Base as B 
Py_R_shift = findShift_Py(R, B, 3);
Py_G_shift = findShift_Py(G, B, 3);
PyR = circshift(R, Py_R_shift);
PyG = circshift(G, Py_G_shift);
im = cat(3,PyR,PyG,B);
imwrite(im, '01657u_aligned_pyramidal_baseB.jpg')