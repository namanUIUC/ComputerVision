%% FUNCTION TO PERFORM VISIALIZATION OF SCALING
function visualization(image,i,s)
imagesc(image);
colorbar;
title(sprintf('Showing the filter response for iteration %d, sigma = %0.3f',i, s));
truesize;