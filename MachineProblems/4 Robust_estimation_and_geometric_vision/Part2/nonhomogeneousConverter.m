function [x] = nonhomogeneousConverter(data)
    
    %% CONVERT DATA FROM [X Y Z] -> [X/Z Y/Z]
    features = size(data, 2) - 1;
    norm = bsxfun(@rdivide,data,data(:,end));
    x = norm(:,1:features);
end