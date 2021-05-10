function matriceMedia = matriceMedia(matrix, zeroValue)
    % fix la matrice sistemando i valori =0
    matrix = FixMatrix(matrix, zeroValue);
    
    sizes = size(matrix);
    
    totH = sizes(1);
    totW = sizes(2);
    
    kk=1;
    while totH>0
        if totH>10
            quadratiH(kk) = 10;
            totH= totH-10;
            kk = kk+1;
        else
            quadratiH(kk) = totH;
            totH=0;
        end
    end
    
    kk=1;
    while totW>0
        if totW>10
            quadratiW(kk) = 10;
            totW= totW-10;
            kk = kk+1;
        else
            quadratiW(kk) = totW;
            totW=0;
        end
    end
    
    B = mat2cell(matrix,quadratiH,quadratiW); % creo matrice con celle 10x10 dell'originale

    matriceMedia = zeros(size(B,1),size(B, 2));

    for i = 1:size(B,1)
        for j  = 1:size(B,2)
            matriceMedia(i,j) = mean(B{i, j}, 'all');
        end
    end
    
end