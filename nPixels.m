function nPixels = nPixels(matrix, error)
    minMatrix = min(matrix(:));
    maxMatrix = max(matrix(:));
    delta = maxMatrix - minMatrix;
    interval = delta/100 * error;
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
                    depthValues(pos) = depthValues(pos) + 1;
                else
                    depthKeys = [depthKeys; matrix(i, j)];
                    depthValues = [depthValues; 1];
                end
            end
        end
    end
    for i=1:size(depthKeys)
        depthKeys(i) = depthKeys(i)/delta;
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