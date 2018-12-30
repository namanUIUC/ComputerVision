function [ x ] = homogeneousConverter(data)

    count = size(data,1); 
    features = size(data,2);
    x = ones(count, features+1);
    x(:,1 : features) = data(:,1:features);
end