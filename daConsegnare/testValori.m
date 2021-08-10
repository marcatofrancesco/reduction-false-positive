% questo file testa vari valori di marginRate per verificarne la Precision e il Recall

testingPrecision = zeros(40,2); %matrice di Precision
testingRecall = zeros(40,2); %matrice di Recall

marginRate = 0.3

k = 1;

while marginRate <= 0.7
    % il seguente metodo popolerà l'array results con i risultati del metodo. ogni indice nell'array corrisponde alla corrispondente immagine in DepthDATA con lo stesso indice. I risultiati sono cos' rappresentati: 1--> non face, 0.5 --> face    
    results = zeros(size(transpose(DepthDATA),1), 1); %inizializzo l'array results vuoto
    
    for i = 1:size(transpose(DepthDATA)) % analizzo tutte le immagini presenti in DepthDATA

        matrix = DepthDATA{i}{2}; % considero la depth map della regione trovata dal face detector
        maxMatrix = max(matrix(:)); % individuo il valore massimo all'interno della matrice

        fixedMatrix = FixMatrix(matrix, maxMatrix); % aggiusto i valori che sono =0, quindi catturati erroneamente dal depth sensor
        matrixVCenter = round(size(fixedMatrix, 1)/2); % trovo il centro della matrice
        centralrow = fixedMatrix(matrixVCenter,:); % salvo nell'array centralrow i valori della riga centrale della metrice fixedMatrix

        % preparo i dati per effettuare il fit e la regressione parabolica
        x = transpose(1:size(centralrow, 2));
        y = double(transpose(centralrow));

        f=fit(x,y,'poly2'); % effettuo la regressione parabolica

        coefficientValues = coeffvalues(f); % estraggo i coefficenti dell'equazione di secondo grado dal fit

        vertice = -coefficientValues(2)/(2.*coefficientValues(1));  % individuo il vertice della parabola

        matrixHCenter = round(size(fixedMatrix, 2)/2);

        marginA = matrixHCenter - marginRate*size(fixedMatrix, 1);
        marginB = matrixHCenter + marginRate*size(fixedMatrix, 1);

        if (vertice < marginA || vertice > marginB || coefficientValues(1) < 0) % controllo che il vertice sia esterno all'immagine
            results(i, 1) = 1; % se il vertice è all'esterno dell'immagine, essa viene identificata come nonFace
        else
            results(i, 1) = 0.5; % altrimenti viene identificata come face
        end

    end
    
    % stampa ad output i risultati del cluster
    giuste = 0;
    sbagliate = 0;
    nonIndividuate = 0;
    totaleNF = 0;
    for i = 1:size(results)
        if DepthDATA{i}{8} == 1
            totaleNF = totaleNF +1;
        end
        if DepthDATA{i}{8} == 1 && results(i)== 0.5
            nonIndividuate = nonIndividuate+1;
        end
        if results(i)== 1
            if DepthDATA{i}{8} == 0.5
                sbagliate = sbagliate+1;
            else
                giuste = giuste+1;
            end
        end
    end
    
    TP = giuste;
    FP = sbagliate;
    FN = nonIndividuate;
    
    precision = TP/(TP+FP);
    recall = TP/(TP+FN);
    
    testingPrecision(k, 1) = marginRate;
    testingPrecision(k, 2) = precision;
    
    testingRecall(k, 1) = marginRate;
    testingRecall(k, 2) = recall;
    
    marginRate = marginRate + 0.01
    k = k + 1;
    
end

hold on
scatter(testingPrecision(:,1), testingPrecision(:,2), 'filled');
line(testingPrecision(:,1), testingPrecision(:,2))

scatter(testingRecall(:,1), testingRecall(:,2), 'filled', 'red');
line(testingRecall(:,1), testingRecall(:,2), 'Color', 'red')

