function image_cropped = auto_remove_bounds(image, eps)

if nargin < 2
    eps = 1e-3;
end

image = remove_one_side(image, eps);
image = remove_one_side(flipud(image), eps);
image = permute(image, [2, 1, 3]);
image = remove_one_side(image, eps);
image = remove_one_side(flipud(image), eps);

image_cropped = rot90(permute(image, [2, 1, 3]),2);

end

function image_cropped = remove_one_side(image, eps)

[imh, ~, imc] = size(image);

for idh=1:imh
    min_cor = 1;
    for idc=1:imc
        patch = image(idh, :, idc);
        patch = patch(:);
        pm = mean(patch);
        pv = mean((patch - pm) .^ 2);
        min_cor = min(pv, min_cor);
    end
    if min_cor > eps
        break;
    end
end

image_cropped = image(idh:end, :, :);

end
