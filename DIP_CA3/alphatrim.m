% alphatrim
function result_img = alphatrim(img, kernel_size, alpha)
    [rows, cols] = size(img);
    result_img = zeros(rows, cols);
    img_padded = padarray(img, [floor(kernel_size/2), floor(kernel_size/2)], 'replicate');
    for i = 1:rows
        for j = 1:cols
            neighbors = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            sorted_neighbors = sort(neighbors(:));
            trimmed_neighbors = sorted_neighbors(floor(alpha/2)+1:end-floor(alpha/2));
            result_img(i, j) = mean(trimmed_neighbors);
        end
    end
end