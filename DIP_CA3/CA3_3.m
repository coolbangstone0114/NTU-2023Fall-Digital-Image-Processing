%% Problem 3: Salt-and-pepper noise reduction
clc; clear;
import adpmedian.m.*
import calculate_psnr.m.*
import outliner.m.*
import midpoint.m.*
import alphatrim.m.*
% Read the image and create noise
original_img = imread('woman_blonde.tif');
noisy_img_1 = imnoise(original_img, 'salt & pepper', 0.1);
noisy_img_2 = imnoise(original_img, 'salt & pepper', 0.4);

% % Apply filters for noise density 0.1
% [AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(original_img, noisy_img_1, 'adaptive-median', 3, 15, 2);
% [Mresult,Mpsnr,Mkernel,~,~] = fine_tune_filter(original_img, noisy_img_1, 'median', 3, 15, 2);
% [ATresult,ATpsnr,ATkernel,~,ATalpha] = fine_tune_filter(original_img, noisy_img_1, 'alphatrim', 3, 15, 2);
% [MPresult, MPpsnr,MPkernel,~,~] = fine_tune_filter(original_img, noisy_img_1, 'midpoint', 3, 15, 2);
% [Oresult,Opsnr,Okernel,D,~] = fine_tune_filter(original_img, noisy_img_1, 'outlier', 3, 15, 2);
% 
% 
% % Display results for noise density 0.1
% figure;
% subplot(4, 2, 1); imshow(uint8(original_img)); title('Original');
% subplot(4, 2, 2); imshow(uint8(noisy_img_1)); title('Noisy (Var = 0.1)');
% subplot(4, 2, 3); imshow(Mresult); title(['Median (PSNR = ' num2str(Mpsnr) ')']);
% subplot(4, 2, 4); imshow(ATresult); title(['Alpha-Trimmed Mean (PSNR = ' num2str(ATpsnr) ', \alpha = ' num2str(ATalpha) ')']);
% subplot(4, 2, 5); imshow(MPresult); title(['Midpoint (PSNR = ' num2str(MPpsnr) ')']);
% subplot(4, 2, 6); imshow(Oresult); title(['Outlier (PSNR = ' num2str(Opsnr) ', D = ' num2str(D) ')']);
% subplot(4, 2, 7); imshow(AMresult); title(['Adaptive median (PSNR = ' num2str(AMpsnr) ')']);

% Apply filters for noise density 0.4
[Mresult,Mpsnr,Mkernel,~,~] = fine_tune_filter(original_img, noisy_img_2, 'median', 3, 15, 2);
[ATresult,ATpsnr,ATkernel,~,ATalpha] = fine_tune_filter(original_img, noisy_img_2, 'alphatrim', 3, 15, 2);
[MPresult, MPpsnr,MPkernel,~,~] = fine_tune_filter(original_img, noisy_img_2, 'midpoint', 3, 15, 2);
[Oresult,Opsnr,Okernel,D,~] = fine_tune_filter(original_img, noisy_img_2, 'outlier', 3, 15, 2);
[AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(original_img, noisy_img_2, 'adaptive-median', 3, 15, 2);

% Display results for noise density 0.4
figure;
subplot(4, 2, 1); imshow(uint8(original_img)); title('Original');
subplot(4, 2, 2); imshow(uint8(noisy_img_1)); title('Noisy (Var = 0.4)');
subplot(4, 2, 3); imshow(Mresult); title(['Median (PSNR = ' num2str(Mpsnr) ')']);
subplot(4, 2, 4); imshow(ATresult); title(['Alpha-Trimmed Mean (PSNR = ' num2str(ATpsnr) ', \alpha = ' num2str(ATalpha) ')']);
subplot(4, 2, 5); imshow(MPresult); title(['Midpoint (PSNR = ' num2str(MPpsnr) ')']);
subplot(4, 2, 6); imshow(Oresult); title(['Outlier (PSNR = ' num2str(Opsnr) ', D = ' num2str(D) ')']);
subplot(4, 2, 7); imshow(AMresult); title(['Adaptive median (PSNR = ' num2str(AMpsnr) ')']);

%% Fine tuning functions
function [best_result, best_psnr, best_kernel_size, D, alpha] = fine_tune_filter(original_img, noisy_img, filter_type, min_size, max_size, step)
    best_psnr = 0;
    best_result = [];
    best_kernel_size = [];

    for kernel_size = min_size:step:max_size
        [D, alpha, restored_img] = filter_image(original_img, noisy_img, filter_type, kernel_size);
        psnr_value = calculate_psnr(original_img, restored_img);

        % Update if current PSNR is better than the previous best
        if psnr_value > best_psnr
            best_psnr = psnr_value;
            best_result = uint8(restored_img);
            best_kernel_size = kernel_size;
        end
    end
end

%用於濾波的function
function [D, alpha, result_img] = filter_image(original_img, img, filter_type, kernel_size)
    alpha = -1;
    D = -1;
    switch filter_type
        case 'midpoint'
            result_img = midpoint(img, kernel_size);
        case 'outlier' % Modify value D using loop
            best_psnr = -Inf;
            best_D = -1;
            for D=60:1:80
                disp(D)
                restored_img = outliner(img, kernel_size, D);
                psnr_value = calculate_psnr(original_img, restored_img);
                % Update if current PSNR is better than the previous best
                if psnr_value > best_psnr
                    best_psnr = psnr_value;
                    best_D = D;
                    result_img = uint8(restored_img);
                end
            end
            D = best_D;
        case 'adaptive-median'
            result_img = adpmedian(img, kernel_size);
        case 'median'
            result_img = medfilt2(img, [kernel_size, kernel_size]);
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