function [ C ] = findCameraCenter( P )
    [~, ~, V] = svd(P);
    C = V(:,end);
    C = nonhomogeneousConverter(C');
end
