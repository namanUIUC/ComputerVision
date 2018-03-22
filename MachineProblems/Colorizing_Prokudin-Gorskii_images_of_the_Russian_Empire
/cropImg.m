function [cropped] = cropImg(A,p)
% Teh function will crop Image A with p aspect percentage 
crop = floor(p*size(A));
sh = crop(1); 
eh = size(A,1) - crop(1);
sw = crop(2);
ew = size(A,2) - crop(2);
cropped = A(sh:eh,sw:ew);
end