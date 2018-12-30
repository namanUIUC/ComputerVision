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

%% IMAGE AND DATA INPUT
full_path = sprintf('%s%s', root_path, image_name);
image = imread(full_path);


%% Hyper parameters (if any)
Sigma = 2;                                      % User defined
ScaleStep = 12;                                 % User defined
threshold = 0.2;                              % Typically 0.00001 - 0.1
method = 'Down';                               % vals: 'Up', 'Down'
time = true;                                   % vals: true, false
implementation = 0;                            % vals: BruteForce=0, DoG=1 [NOT SUPPORT]

BlobDetection(image, Sigma, ScaleStep, threshold, method, implementation, time)




