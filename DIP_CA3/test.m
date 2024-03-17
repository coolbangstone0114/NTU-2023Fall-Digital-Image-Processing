clc;clear;
import midpoint.m.*

input_matrix = [
    -1, 2, 3;
    4, 5, 6;
    7, 8, 99
];

kernel_size = 3;  % 選擇 3x3 的卷積核

result_img = midpoint(input_matrix, kernel_size);

disp('原始矩陣:');
disp(input_matrix);

disp('應用中點濾波後的矩陣:');
disp(result_img);
