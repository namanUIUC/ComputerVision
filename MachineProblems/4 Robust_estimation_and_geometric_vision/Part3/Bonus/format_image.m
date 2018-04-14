%% FUNCTION TO PERFORM BASIC FORMATING TO INPUT IMAGE
function [image] = format_image(image,channel)
% Grey Scale conversion
if channel==3
    image=rgb2gray(image);
end

% Normalization
image=double(image);
image=image/255;
