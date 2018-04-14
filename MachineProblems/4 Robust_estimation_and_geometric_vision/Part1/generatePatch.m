function descriptor = generatePatch(img, row, col, corners, patch_size)
descriptor = zeros(corners, (2*patch_size+1)^2);

    for i = 1:corners
        patch = img(row(i)-patch_size:row(i)+patch_size, col(i)-patch_size:col(i)+patch_size);
        descriptor(i,:) = reshape(patch, 1, (2*patch_size+1)^2);
    end
end