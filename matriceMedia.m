function matriceMedia = matriceMedia(matrix)
    % fix la matrice sistemando i valori =0
    matrix = FixMatrix(matrix);
    
    tot = size(matrix, 1);
    quadrati = [];
    kk = 1;
    while tot>0
        if tot>10
            quadrati(kk) = 10;
            tot= tot-10;
            kk = kk+1;
        else
            quadrati(kk) = tot;
            tot= tot-tot;
        end
    end

    B = mat2cell(matrix,quadrati,quadrati); % creo matrice con celle 10x10 dell'originale

    matriceMedia = zeros(size(B,1),size(B, 2));

    for i = 1:size(B,1)
        for j  = 1:size(B,2)
            matriceMedia(i,j) = mean(B{i, j}, 'all');
        end
    end
    
end