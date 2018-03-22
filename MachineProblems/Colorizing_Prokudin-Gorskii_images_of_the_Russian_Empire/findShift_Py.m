function [shift] = findShift_Py(Temp, Base, N)
if N == 0
    % would execute for the top of the pyramid image
    shift = edges_findshift(Temp, Base, 15); 
else
    
    %dimension reduction (scaling down)
    Temp_scaled = impyramid(Temp, 'reduce');
    Base_scaled =  impyramid(Base, 'reduce');
    
    %recursion
    shift = findShift_Py(Temp_scaled, Base_scaled, N-1)*2; 
    Temp = circshift(Temp, shift);
    
    shift = shift + edges_findshift(Temp, Base, 2);
end