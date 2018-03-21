%% FUNCTION TO RETURN STACK OF ALL CIRCLE PIXELS
function [X, Y, R] = get_circles(Best_SS, threshold, Sigma, k)
% Initialize pixels
X = [];
Y = [];
R = [];

% For each stride in the 
for i=1:size(Best_SS,3)
    
    % Caluclate radius
    radius=2^0.5*Sigma*k^(i-1);
    
    % Threshold servival
    [indx1,indx2] = find(Best_SS(:,:,i)>=threshold);
    
    % Finding circle pixels
    if i==1
        [a,b,rad]=get_circle_pixel(indx2, indx1, radius);
        X=a;
        Y=b;
        R=rad;
        
    else
        [a,b,rad]=get_circle_pixel(indx2, indx1, radius);
        X = [X; a];
        Y = [Y; b];
        R = [R; rad];
        
    end
    
end