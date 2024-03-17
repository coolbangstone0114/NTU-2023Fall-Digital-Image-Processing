% Function to calculate PSNR
function psnr_value = calculate_psnr(original_img, restored_img)
    [rows, cols] = size(original_img);
    mse = sum((double(original_img(:)) - double(restored_img(:))).^2);
    % Check if MSE is zero to avoid division by zero
    if mse == 0
        psnr_value = Inf;  % PSNR is infinity for identical images
    else
        %max_intensity = double(max(original_img(:)));
        % Max possible intensity is 255
        psnr_value = 10 * log10(cols * rows * (255*255) / mse);
    end
end