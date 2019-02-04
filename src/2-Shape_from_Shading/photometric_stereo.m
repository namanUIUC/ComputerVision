function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals

%% <<< fill in your code below >>>
tic
h = size( imarray, 1 );
w = size( imarray, 2 );
imSize = h * w;
ImVec = transpose(reshape( imarray, imSize, size( imarray, 3 ) ));



% x is of dim [3 x npix]
x = light_dirs\ImVec;

% alb is of dim [1 x npix]
alb = sqrt(sum(x.^2,1));
% N is of dim [3 x npix]
N = bsxfun(@rdivide, x, alb);

N = transpose(N);
surface_normals = reshape( N, h, w, size( N, 2));

alb = transpose(alb);
albedo_image = reshape( alb, h, w);
toc
end

