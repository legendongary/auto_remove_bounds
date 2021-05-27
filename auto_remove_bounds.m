function image_cropped = auto_remove_bounds(image, eps)

image = im2double(image);

if ndims(image) == 3
    image_input = rgb2gray(image);
else
    image_input = image;
end

[IMH, IMW] = size(image_input);

id1 = start_removing(image_input, eps) + 1;
id2 = IMH - start_removing(image_input(end:-1:1, :), eps) - 1;
id3 = start_removing(image_input(:, end:-1:1), eps) + 1;
id4 = IMW - start_removing(image_input(end:-1:1, end:-1:1), eps) - 1;

image_cropped = image(id1:id2, id3:id4, :);

end

function crop_idx = start_removing(image, eps)

[IMH, ~] = size(image);

for i=1:IMH
    patch = image(i, :);
    patch = patch(:);
    patch_mean = mean(patch);
    patch_corr = mean((patch - patch_mean) .^ 2);
    if patch_corr > eps
        break;
    end
end

crop_idx = i;

end
