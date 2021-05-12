function newm = FixMatrix(matrix, zeroValue)
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
                if ~exist('zeroValue','var')
                    newm(i,j)=maxMatrix;
                else
                    newm(i,j)=zeroValue;
                end
            else
                %newm(i,j) = double(matrix(i,j))/double(maxMatrix);
                newm(i,j) = double(matrix(i,j));
            end
        end
    end
end