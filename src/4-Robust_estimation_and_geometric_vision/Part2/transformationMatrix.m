function [ t ] = transformationMatrix(homogeneousData)
    muX = mean(homogeneousData(:,1));
    muY = mean(homogeneousData(:,2));
    maxX= max(abs(homogeneousData(:,1)));
    maxY= max(abs(homogeneousData(:,2)));
    t = eye(3);
    t(1,1) = 1/maxX;
    t(1,3) = -muX/maxX;
    t(2,2) = 1/maxY;
    t(2,3) = -muY/maxY;
end