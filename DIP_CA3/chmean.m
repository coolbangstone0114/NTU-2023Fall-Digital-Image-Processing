% chmean
function output_image = chmean(input_image, window_size, Q)
    % CONTRAHARMONIC_MEAN_FILTER applies contraharmonic mean filtering to an image.
    %
    %   output_image = CONTRAHARMONIC_MEAN_FILTER(input_image, window_size, Q) 
    %   applies contraharmonic mean filtering to the input_image using a 
    %   window of size window_size and a parameter Q.
    %
    %   Parameters:
    %       - input_image: the input grayscale image.
    %       - window_size: the size of the window for filtering.
    %       - Q: the order parameter of the contraharmonic mean filter.
    %
    %   Output:
    %       - output_image: the filtered image.
    
    % Ensure the window size is odd
    if mod(window_size, 2) == 0
        error('Window size must be odd.');
    end

    % Get the dimensions of the input image
    [rows, cols] = size(input_image);

    % Initialize the output image
    output_image = zeros(rows, cols);

    % Pad the input image
    padded_image = padarray(input_image, [(window_size-1)/2, (window_size-1)/2], 'replicate');

    % Apply contraharmonic mean filtering
    for i = 1:rows
        for j = 1:cols
            % Extract the window
            window = double(padded_image(i:i+window_size-1, j:j+window_size-1));
            % Compute the contraharmonic mean
            numerator_matrix = window.^(Q + 1);
            numerator = sum(numerator_matrix(:));
            denominator_matrix = window.^(Q);
            denominator = sum(denominator_matrix(:));

            % Avoid division by zero
            if denominator ~= 0
                output_image(i, j) = uint8(numerator / denominator);
            else
                output_image(i, j) = uint8(0);
            end
        end
    end

    % Convert the output image to the same data type as the input
    output_image = cast(output_image, class(input_image));
end
