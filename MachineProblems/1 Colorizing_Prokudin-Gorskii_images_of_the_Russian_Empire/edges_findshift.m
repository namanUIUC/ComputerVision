function [ shift ] = edges_findshift( foreground,Background,rotation_window )
% This function is for calculating SSD and returning the shifting
% coordinates of the shifted image.
min_val = inf;

%cropping ratio
p = 0.08;
Background_c = cropImg(Background,p);

for xi = -rotation_window:rotation_window
    for yi = -rotation_window:rotation_window
        
        Shifted_foreground = circshift(foreground,[xi yi]);        
        Shifted_foreground_c = cropImg(Shifted_foreground,p);
        
        ssd = sumsqr(Background_c - Shifted_foreground_c);
        
        if ssd < min_val
            min_val = ssd;
            best = [xi yi];
        end
    end
end

shift = best;

end
