function nPixels = nPixels(matrix, error, stdSize)
    minMatrix = min(matrix(:));
    maxMatrix = max(matrix(:));
    meanM = mean(matrix(:), 'omitnan');
    variance = var(matrix(:), 'omitnan');
    delta = maxMatrix-minMatrix;
    interval = delta * error/100;
    depthKeys = [];
    depthValues = [];
    
    sizes = size(matrix);
    
    height = sizes(1);
    length = sizes(2);
    
    for i=1:height
        for j=1:length
            if ~isnan(matrix(i,j))
                minValue = (matrix(i,j) - interval);
                maxValue = (matrix(i,j) + interval);
                pos = search(depthKeys, minValue, maxValue);
                if pos ~= -1
                    depthKeys(pos) = (depthKeys(pos) * depthValues(pos)) + matrix(i,j);
                    depthValues(pos) = depthValues(pos) + 1;
                    depthKeys(pos) = depthKeys(pos)/depthValues(pos); %aggiorno la media della depth
                else
                    depthKeys = [depthKeys; matrix(i, j)];
                    depthValues = [depthValues; 1];
                end
            end
        end
    end
    %normalizzo i valori
    for i=1:size(depthKeys)
        %depthKeys(i) = (depthKeys(i)-meanM)/variance;
        depthKeys(i) = (depthKeys(i)-minMatrix)/delta;
        depthValues(i) = (depthValues(i) * power(stdSize,2))/(height*length);
    end
    nPixels = containers.Map(depthKeys,depthValues);
end

function pos = search(depthKeys, min, max)
    pos = -1;
    for i=1:size(depthKeys)
        if depthKeys(i) >= min & depthKeys(i) <= max
            pos = i;
        end
    end
end