function newm = FixMatrix(matrix)
    minMatrix = min(matrix(:));
    maxMatrix = max(matrix(:));
    
    sizes = size(matrix);
    
    height = sizes(1);
    length = sizes(2);
    
    newm = zeros(height, length);

    % creo nuova matrice con valori nuovi
    for i = 1:height
        for j = 1:length

            if double(matrix(i,j))==0
                %newm(i,j)=maxMatrix;
                newm(i,j)=maxMatrix;
            else
                %newm(i,j) = double(matrix(i,j))/double(maxMatrix);
                newm(i,j) = double(matrix(i,j));
            end
        end
    end
end