function data = get_pixelTopBottom(X,Y)
    data = [];
    for i=1:size(X,1)
        Xpix = double(int16(mean(X(i,:))));
        Ypix_max = double(int16(max(Y(i,:))));
        Ypix_min = double(int16(min(Y(i,:))));
        temp = [Xpix,Ypix_max,1,Xpix,Ypix_min,1];
        data = [data; temp];
    end

end