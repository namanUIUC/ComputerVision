function [new_row, new_col, corners] = refineCorners(r, c, h, w, patch)
new_row = [];
new_col = [];
corners = size(r,1);
for i = 1:corners
    if((r(i) > patch) && (c(i) > patch))
        if (r(i) < h-patch-1) && (c(i) < w-patch-1)
            new_row = [new_row; r(i)];
            new_col = [new_col; c(i)];
        end

    end
    
end
corners = size(new_row,1);
end