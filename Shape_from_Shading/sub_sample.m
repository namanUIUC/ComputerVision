function [im_new, light_new]=sub_sample(im, light, k, filt)
score = 0;
im_new = [];
light_new = [];

for i=1:64
    score = (mean(mean(im(:,:,i))));
    if (score>=k)
        if (filt == 1)
            im_new = cat(3,im_new,imgaussfilt(im(:,:,i)));
        elseif (filt == 2)
            im_new = cat(3,im_new,imsharpen(im(:,:,i)));
        else
            im_new = cat(3,im_new,(im(:,:,i)));
        end
        
        light_new = cat(1,light_new,light(i,:));
    end
end

end
