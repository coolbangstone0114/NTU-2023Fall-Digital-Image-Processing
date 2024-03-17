% outliner
function result_img = outliner(image, kernel_size, D)
    [rows, cols] = size(image);
    result_img = zeros(rows, cols);
    % Pad the image to handle boundary pixels
    paddedImage = padarray(image, double([floor(kernel_size/2), floor(kernel_size/2)]), 'replicate');
    for i = 1:rows
        for j = 1:cols
            % Extract the neighborhood
            neighborhood = paddedImage(i:i+kernel_size-1, j:j+kernel_size-1);
            % Calculate mean of the neighborhood
            m = mean(neighborhood(:));
            % Check if the pixel is noisy
            if abs(image(i, j) - m) > D
                % Replace the pixel value with the mean of the neighborhood
                result_img(i, j) = m;
            else
                % Leave the pixel value unchanged
                result_img(i, j) = image(i, j);
            end
        end
    end
end