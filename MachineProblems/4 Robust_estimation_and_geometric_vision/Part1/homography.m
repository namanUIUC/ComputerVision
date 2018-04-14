function H = homography(bracket, sample_size, sample_indx)
A = [];
for i = 1:sample_size
    sample = bracket(sample_indx(i), :);
    xi = sample(3);
    yi = sample(2);
    xj = sample(6);
    yj = sample(5);
    
    xT = [xi, yi, 1];
    A = [A; xT*0, xT, -xT*yj];
    A = [A; xT, xT*0, -xT*xj];
end

[U, S, V] = svd(A);

H = V(:, end);
H = reshape(H, 3, 3);
end