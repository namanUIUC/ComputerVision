function [aligned] = alignImage(foreground,Background,rotation_window,p)
% This function is for calculating SSD
min_val = inf;

%cropping the image
Background_c = cropImg(Background,p);

for xi = -rotation_window:rotation_window
    for yi = -rotation_window:rotation_window
        
        %Move Foreground Image
        Shifted_foreground = circshift(foreground,[xi yi]);        
        Shifted_foreground_c = cropImg(Shifted_foreground,p);
        
        %Calculate the value of SSD
        ssd = sumsqr(Background_c - Shifted_foreground_c);
        if ssd < min_val
            min_val = ssd;
            best = [xi yi];
        end
    end
end

aligned = circshift(foreground,best);
end