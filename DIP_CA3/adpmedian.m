% adpmedian
function outputImage = adpmedian(inputImage, Smax)
    [rows, cols] = size(inputImage);
    outputImage = zeros(rows, cols);
    
    % Constants
    Zmin = min(inputImage(:));
    Zmax = max(inputImage(:));
    
    for i = 1:rows
        for j = 1:cols
            % Initialize window size
            Sxy = 3; % Starting window size
            while Sxy <= Smax
                % Get the local window
                window = getLocalWindow(inputImage, i, j, Sxy);
                
                % Calculate Zmedian
                Zmedian = median(window(:));
                
                % Level A: determine if Zmedian is an impulse or not
                if Zmin < Zmedian && Zmedian < Zmax
                    % Go to Level B
                    % Level B: determine if Zxy is an impulse or not
                    Zxy = inputImage(i, j);
                    if Zmin < Zxy && Zxy < Zmax
                        % Output Zxy
                        outputImage(i, j) = Zxy;
                        break;
                    else
                        % Output Zmedian
                        outputImage(i, j) = Zmedian;
                        break;
                    end
                else
                    % Increase the size of Sxy
                    Sxy = Sxy + 2;
                end
                
                % If Sxy exceeds Smax, output Zmedian
                if Sxy > Smax
                    outputImage(i, j) = Zmedian;
                end
            end
        end
    end
end

function window = getLocalWindow(image, i, j, S)
    halfS = (S - 1) / 2;
    [rows, cols] = size(image);
    
    % Define window limits
    iMin = max(1, i - halfS);
    iMax = min(rows, i + halfS);
    jMin = max(1, j - halfS);
    jMax = min(cols, j + halfS);
    
    % Extract local window
    window = image(iMin:iMax, jMin:jMax);
end
