%% Problem 4: Speckle noise reduction
import calculate_psnr.m.* outliner.m.* midpoint.m.* alphatrim.m.* chmean.m.*
clc;clear;
img = imread('walkbridge.tif');
noisy_img_1 = imnoise(img, 'speckle', 0.1);
noisy_img_2 = imnoise(img, 'speckle', 0.3);

% % Apply filters for noise density 0.1
% 
% [AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(img,noisy_img_1,'arithmetic_mean',3,15,2);
% [Gresult,Gpsnr,Gkernel,~,~,~,Gsigma] = fine_tune_filter(img,noisy_img_1,'gaussian_lowpass',3,15,2);
% [Wresult,Wpsnr,Wkernel,~,~] = fine_tune_filter(img,noisy_img_1,'wiener',3,15,2);
% [Oresult,Opsnr,Okernel,D,~,~,~] = fine_tune_filter(img, noisy_img_1, 'outlier', 3, 15, 2);
% [ATresult,ATpsnr,ATkernel,~,ATalpha,~,~] = fine_tune_filter(img, noisy_img_1, 'alphatrim', 3, 15, 2);
% [MPresult, MPpsnr,MPkernel,~,~,~,~] = fine_tune_filter(img, noisy_img_1, 'midpoint', 3, 15, 2);
% [CHresult, CHpsnr,CHkernel,~,~,Q,~] = fine_tune_filter(img, noisy_img_1, 'chmean', 3, 15, 2);
% 
% % Display results for noise density 0.1
% figure;
% subplot(3, 3, 1); imshow(uint8(img)); title('Original');
% subplot(3, 3, 2); imshow(uint8(noisy_img_1)); title('Noisy (Var = 0.1)');
% subplot(3, 3, 3); imshow(AMresult); title(['arithmetic mean (PSNR = ' num2str(AMpsnr) ')']);
% subplot(3, 3, 4); imshow(ATresult); title(['Alpha-Trimmed Mean (PSNR = ' num2str(ATpsnr) ', \alpha = ' num2str(ATalpha) ')']);
% subplot(3, 3, 5); imshow(MPresult); title(['Midpoint (PSNR = ' num2str(MPpsnr) ')']);
% subplot(3, 3, 6); imshow(Oresult); title(['Outlier (PSNR = ' num2str(Opsnr) ', D = ' num2str(D) ')']);
% subplot(3, 3, 7); imshow(Gresult); title(['gaussian lowpass (PSNR = ' num2str(Gpsnr) ')']);
% subplot(3, 3, 8); imshow(Wresult); title(['wiener (PSNR = ' num2str(Wpsnr) ')']);
% subplot(3, 3, 9); imshow(CHresult); title(['chmean (PSNR = ' num2str(CHpsnr) ', Q = ' num2str(Q) ')']);

% Apply filters for noise density 0.3

[AMresult,AMpsnr,AMkernel,~,~] = fine_tune_filter(img,noisy_img_2,'arithmetic_mean',3,15,2);
[Gresult,Gpsnr,Gkernel,~,~,~,Gsigma] = fine_tune_filter(img,noisy_img_2,'gaussian_lowpass',3,15,2);
[Wresult,Wpsnr,Wkernel,~,~] = fine_tune_filter(img,noisy_img_2,'wiener',3,15,2);
[Oresult,Opsnr,Okernel,D,~,~,~] = fine_tune_filter(img, noisy_img_2, 'outlier', 3, 15, 2);
[ATresult,ATpsnr,ATkernel,~,ATalpha,~,~] = fine_tune_filter(img, noisy_img_2, 'alphatrim', 3, 15, 2);
[MPresult, MPpsnr,MPkernel,~,~,~,~] = fine_tune_filter(img, noisy_img_2, 'midpoint', 3, 15, 2);
[CHresult, CHpsnr,CHkernel,~,~,Q,~] = fine_tune_filter(img, noisy_img_2, 'chmean', 3, 15, 2);

% Display results for noise density 0.3
figure;
subplot(3, 3, 1); imshow(uint8(img)); title('Original');
subplot(3, 3, 2); imshow(uint8(noisy_img_2)); title('Noisy (Var = 0.1)');
subplot(3, 3, 3); imshow(AMresult); title(['arithmetic mean (PSNR = ' num2str(AMpsnr) ')']);
subplot(3, 3, 4); imshow(ATresult); title(['Alpha-Trimmed Mean (PSNR = ' num2str(ATpsnr) ', \alpha = ' num2str(ATalpha) ')']);
subplot(3, 3, 5); imshow(MPresult); title(['Midpoint (PSNR = ' num2str(MPpsnr) ')']);
subplot(3, 3, 6); imshow(Oresult); title(['Outlier (PSNR = ' num2str(Opsnr) ', D = ' num2str(D) ')']);
subplot(3, 3, 7); imshow(Gresult); title(['gaussian lowpass (PSNR = ' num2str(Gpsnr) ', \sigma = ' num2str(Gsigma) ')']);
subplot(3, 3, 8); imshow(Wresult); title(['wiener (PSNR = ' num2str(Wpsnr) ')']);
subplot(3, 3, 9); imshow(CHresult); title(['chmean (PSNR = ' num2str(CHpsnr) ', Q = ' num2str(Q) ')']);

%% Fine tuning functions
function [best_result, best_psnr, best_kernel_size, D, alpha, Q, Gsigma] = fine_tune_filter(original_img, noisy_img, filter_type, min_size, max_size, step)
    best_psnr = 0;
    best_result = [];
    best_kernel_size = [];

    for kernel_size = min_size:step:max_size
        [Q, D, Gsigma, alpha, restored_img] = filter_image(original_img, noisy_img, filter_type, kernel_size);
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
function [Q, D, gaussian_sigma, alpha, result_img] = filter_image(original_img, img, filter_type, kernel_size)
    gaussian_sigma = -1;alpha = -1;D = -1;Q = -Inf;
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
        case 'wiener'
            result_img = wiener2(img, [kernel_size, kernel_size]);
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
        case 'chmean'
            best_psnr = -Inf;
            best_Q = -Inf;
            for test_Q = -3:3
                fprintf("Q is %d\n", test_Q);
                restored_img = chmean(img,kernel_size,test_Q);
                psnr_value = calculate_psnr(original_img, restored_img);
                % Update if current PSNR is better than the previous best
                if psnr_value > best_psnr
                    best_psnr = psnr_value;
                    best_Q = test_Q;
                    best_result_img = uint8(restored_img);
                end
            end
            result_img = best_result_img;
            Q = best_Q;
        otherwise
            error('Unsupported filter type');
    end
end

%% Filter functions
% Function to filter with Gaussian lowpass
function result_img = filter_with_gaussian(img, kernel_size, sigma)
    h = fspecial('gaussian', kernel_size, sigma);
    result_img = filter2(h, img);
end

function result_img = filter_with_arithmetic_mean(img, kernel_size)
    h = fspecial('average', kernel_size);
    result_img = filter2(h, img);
end