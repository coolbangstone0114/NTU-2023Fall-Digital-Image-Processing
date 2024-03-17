% midpoint
function result_img = midpoint(img, kernel_size)
    result_img = uint8(nlfilter(img, [kernel_size, kernel_size], @(x) (max(x(:)) + min(x(:))) / 2));
end