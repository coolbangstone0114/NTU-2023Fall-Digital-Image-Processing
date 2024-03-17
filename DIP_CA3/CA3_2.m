%% Problem 2: Gaussian noise reduction
clc;clear;
% Read the image and create noise
img = imread('peppers_gray.tif');
noisy_img_1 = imnoise(img, 'gaussian', 0, 0.05);
noisy_img_2 = imnoise(img, 'gaussian', 0, 0.2);
% %% Find the best psnr for 0.05 (使用時記得調整function)
% [AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(img,noisy_img_1,'arithmetic_mean',3,15,2);
% [Gresult,Gpsnr,Gkernel,Gsigma,~] = fine_tune_filter(img,noisy_img_1,'gaussian_lowpass',3,15,2);
% [Mresult,Mpsnr,Mkernel,~,~] = fine_tune_filter(img,noisy_img_1,'median',3,15,2);
% [Wresult,Wpsnr,Wkernel,~,~] = fine_tune_filter(img,noisy_img_1,'wiener',3,15,2);
% [ATresult,ATpsnr,ATkernel,~,ATalpha] = fine_tune_filter(img,noisy_img_1,'alphatrim',3,15,2);
% 
% figure;
% subplot(1, 3, 1); imshow(uint8(img)); title('original');
% subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.05)');
% subplot(1, 3, 3); imshow(AMresult); title('Arithmetic Mean');
% figure;
% subplot(1, 3, 1); imshow(uint8(img)); title('original');
% subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.05)');
% subplot(1, 3, 3); imshow(Gresult); title('Gaussian');
% figure;
% subplot(1, 3, 1); imshow(uint8(img)); title('original');
% subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.05)');
% subplot(1, 3, 3); imshow(Mresult); title('Median');
% figure;
% subplot(1, 3, 1); imshow(uint8(img)); title('original');
% subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.05)');
% subplot(1, 3, 3); imshow(Wresult); title('Wiener');
% figure;
% subplot(1, 3, 1); imshow(uint8(img)); title('original');
% subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.05)');
% subplot(1, 3, 3); imshow(ATresult); title('Alpha-Trimmed Mean');

%% Find the best psnr for 0.2 (使用時記得調整function)
[AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(img,noisy_img_2,'arithmetic_mean',3,15,2);
[Gresult,Gpsnr,Gkernel,Gsigma,~] = fine_tune_filter(img,noisy_img_2,'gaussian_lowpass',3,15,2);
[Mresult,Mpsnr,Mkernel,~,~] = fine_tune_filter(img,noisy_img_2,'median',3,15,2);
[Wresult,Wpsnr,Wkernel,~,~] = fine_tune_filter(img,noisy_img_2,'wiener',3,15,2);
[ATresult,ATpsnr,ATkernel,~,ATalpha] = fine_tune_filter(img,noisy_img_2,'alphatrim',3,15,2);

figure;
subplot(1, 3, 1); imshow(uint8(img)); title('original');
subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.2)');
subplot(1, 3, 3); imshow(AMresult); title('Arithmetic Mean');
figure;
subplot(1, 3, 1); imshow(uint8(img)); title('original');
subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.2)');
subplot(1, 3, 3); imshow(Gresult); title('Gaussian');
figure;
subplot(1, 3, 1); imshow(uint8(img)); title('original');
subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.2)');
subplot(1, 3, 3); imshow(Mresult); title('Median');
figure;
subplot(1, 3, 1); imshow(uint8(img)); title('original');
subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.2)');
subplot(1, 3, 3); imshow(Wresult); title('Wiener');
figure;
subplot(1, 3, 1); imshow(uint8(img)); title('original');
subplot(1, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy Image (Var = 0.2)');
subplot(1, 3, 3); imshow(ATresult); title('Alpha-Trimmed Mean');

%% Fine tuning functions
function [best_result, best_psnr, best_kernel_size, gaussian_sigma, alpha] = fine_tune_filter(original_img, noisy_img, filter_type, min_size, max_size, step)
    best_psnr = 0;
    best_result = [];
    best_kernel_size = [];

    for kernel_size = min_size:step:max_size
        [alpha, gaussian_sigma, restored_img] = filter_image(original_img, noisy_img, filter_type, kernel_size);
        psnr_value = calculate_psnr(original_img, restored_img);

        % Update if current PSNR is better than the previous best
        if psnr_value > best_psnr
            best_psnr = psnr_value;
            best_result = uint8(restored_img);
            best_kernel_size = kernel_size;
        end
    end
end

function [alpha, gaussian_sigma, result_img] = filter_image(original_img, img, filter_type, kernel_size)
    gaussian_sigma = -1;  % Default value for cases other than 'gaussian_lowpass'
    alpha = -1;
    switch filter_type
        case 'arithmetic_mean'
            result_img = filter_with_arithmetic_mean(img, kernel_size);
        case 'gaussian_lowpass'
            best_psnr = -Inf;
            best_sigma = -1;
            for sigma = 0.01:0.01:2
                restored_img = filter_with_gaussian(img, kernel_size, sigma);
                psnr_value = calculate_psnr(original_img, restored_img);
                % Update if current PSNR is better than the previous best
                if psnr_value > best_psnr
                    best_psnr = psnr_value;
                    best_sigma = sigma;
                    best_result_img = uint8(restored_img);
                end
            end
            result_img = best_result_img;
            gaussian_sigma = best_sigma;
        case 'median'
            result_img = medfilt2(img, [kernel_size, kernel_size]);
        case 'wiener'
            result_img = wiener2(img, [kernel_size, kernel_size]);
        case 'alphatrim'
            best_psnr = -Inf;
            best_alpha = -1;
            for alpha = 0.1:0.1:0.5
                restored_img = alphatrim(img, kernel_size, alpha);
                psnr_value = calculate_psnr(original_img, restored_img);
                % Update if current PSNR is better than the previous best
                if psnr_value > best_psnr
                    best_psnr = psnr_value;
                    best_alpha = alpha;
                    best_result_img = uint8(restored_img);
                end
            end
            result_img = best_result_img;
            alpha = best_alpha;
        otherwise
            error('Unsupported filter type');
    end
end

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

%% Filter functions
% Function to filter with arithmetic mean
function result_img = filter_with_arithmetic_mean(img, kernel_size)
    h = fspecial('average', kernel_size);
    result_img = filter2(h, img);
end

% Function to filter with Gaussian lowpass
function result_img = filter_with_gaussian(img, kernel_size, sigma)
    h = fspecial('gaussian', kernel_size, sigma);
    result_img = filter2(h, img);
end

% Function for alpha-trimmed mean filter
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
