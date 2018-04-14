% Spring 2018 CS 543 Assignment 3
% Part 3
%% NAMAN SHUKLA

clear all;
clc;

%% PARAMETERS
root_path = 'data/';
image_name = 'CSL.jpg'; 
estimate = false;
display = true;
CSL   = [599,313,1,599,49,1];
Spike = [602,474,1,602,251,1];
Lamp  = [711,408,1,711,325,1];
man1 = [473, 576, 1, 472, 521, 1];
man2 = [454, 565, 1, 454, 517, 1];
windowUU = [789,177,1,789,157,1];
windowDD = [785,276,1,785,247,1];
data = [CSL;Spike;Lamp;man1;man2;windowDU;windowUU;windowDD];
%% IMAGE AND DATA INPUT
full_path = sprintf('%s%s', root_path, image_name);
image = imread(full_path);


%% ESTIMATE VPs AND HORIZON
[vpx, vpy, vpz, Horizon] = process(image, estimate, display);
processed = [reshape(vpx,1,3); reshape(vpy,1,3); reshape(vpz,1,3); reshape(Horizon,1,3)];

%% FOCAL LENGTH & OPTICAL CENTER
K = caliberation(processed);

%% ROTATION MATRIX
R = rotationMatrix(processed, K);

%% HEIGHT FINDER
H = findHeight(image, processed ,data);




