% il seguente metodo popolerà l'array results con i risultati del metodo. ogni indice nell'array corrisponde alla corrispondente immagine in DepthDATA con lo stesso indice. I risultiati sono cos' rappresentati: 1--> non face, 0.5 --> face

results = []; %inizializzo l'array results vuoto

for i = 1:size(transpose(DepthDATA)) % analizzo tutte le immagini presenti in DepthDATA

    matrix = DepthDATA{i}{2}; % considero la depth map della regione trovata dal face detector
    maxMatrix = max(matrix(:)); % individuo il valore massimo all'interno della matrice

    fixedMatrix = FixMatrix(matrix, maxMatrix); % aggiusto i valori che sono =0, quindi catturati erroneamente dal depth sensor
    matrixCenter = round(size(fixedMatrix, 1)/2); % trovo il centro della matrice
    centralrow = fixedMatrix(matrixCenter,:); % salvo nell'array centralrow i valori della riga centrale della metrice fixedMatrix
    
    % preparo i dati per effettuare il fit e la regressione parabolica
    x = transpose(1:size(centralrow, 2));
    y = transpose(centralrow);
    
    f=fit(x,y,'poly2'); % effettuo la regressione parabolica

    coefficientValues = coeffvalues(f); % estraggo i coefficenti dell'equazione di secondo grado dal fit

    vertice = -coefficientValues(2)/(2.*coefficientValues(1));  % individuo il vertice della parabola

    if (vertice<0 || vertice>size(fixedMatrix, 1)) % controllo che il vertice sia esterno all'immagine

        results(i, 1) = 1; % se il vertice è all'esterno dell'immagine, essa viene identificata come nonFace
    else
        results(i, 1) = 0.5; % altrimenti viene identificata come face

    end
        
end


