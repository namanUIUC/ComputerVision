function [X,Y,R] = get_circle_pixel(cx, cy, rad)
%% DECOMPOSED THE FUNCTION - show_all_circles.m
% cx, cy: column vectors with x and y coordinates of circle centers
% rad: column vector with radii of circles. 
% The sizes of cx, cy, and rad must all be the same

theta = 0:0.1:(2*pi+0.1);
cx1 = cx(:,ones(size(theta)));
cy1 = cy(:,ones(size(theta)));
rad1 = rad(:,ones(size(theta)));
theta = theta(ones(size(cx1,1),1),:);
X = cx1+cos(theta).*rad1;
Y = cy1+sin(theta).*rad1;
R = rad*ones(size(cx,1),1);