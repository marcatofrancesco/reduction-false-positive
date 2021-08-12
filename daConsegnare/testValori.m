% questo file testa vari valori di marginRate per verificarne la Precision e il Recall

testingData = zeros(41,3); %matrice di Precision e Recall

marginRate = 0.4

k = 1;

results = zeros(size(transpose(DepthDATA),1), 1); %inizializzo l'array results vuoto

while marginRate <= 0.8
    
    for i = 1:size(transpose(DepthDATA)) % analizzo tutte le immagini presenti in DepthDATA

        matrix = DepthDATA{i}{2}; % considero la depth map della regione trovata dal face detector
        maxMatrix = max(matrix(:)); % individuo il valore massimo all'interno della matrice

        fixedMatrix = FixMatrix(matrix, maxMatrix); % aggiusto i valori che sono =0, quindi catturati erroneamente dal depth sensor
        matrixVCenter = round(size(fixedMatrix, 1)/2); % trovo la riga centrale della matrice
        centralrow = fixedMatrix(matrixVCenter,:); % salvo nell'array centralrow i valori della riga centrale della metrice fixedMatrix

        % preparo i dati per effettuare il fit e la regressione parabolica
        x = transpose(1:size(centralrow, 2));
        y = double(transpose(centralrow));

        f=fit(x,y,'poly2'); % effettuo la regressione parabolica

        coefficientValues = coeffvalues(f); % estraggo i coefficenti dell'equazione di secondo grado dal fit

        vertice = -coefficientValues(2)/(2.*coefficientValues(1));  % individuo il vertice della parabola

        matrixHCenter = round(size(fixedMatrix, 2)/2); % trovo la colonna centrale della matrice

        marginA = matrixHCenter - marginRate*size(fixedMatrix, 1); % calcolo il primo margine spostandomi a sinistra rispetto alla colonna centrale
        marginB = matrixHCenter + marginRate*size(fixedMatrix, 1); % calcolo il secondo margine spostandomi a destra rispetto alla colonna centrale

        if (vertice < marginA || vertice > marginB || coefficientValues(1) < 0) % controllo che il vertice sia esterno ai margini o che la parabola sia concava
            results(i, 1) = 1; % allora essa viene identificata come nonFace
        else
            results(i, 1) = 0.5; % altrimenti viene identificata come face
        end

    end
    
    % stampa ad output i risultati ottenuti nell'array results
    % dichiaro contatori
    truePositive = 0; % NonFace
    falsePositive = 0; % Face individuati come NonFace
    trueNegative = 0; % Face
    falseNegative = 0; % NonFace individuati come Face

    totaleF = 0; % totale Face
    totaleNF = 0; % totale NonFace
    for i = 1:size(results) % per ogni immagine in result
        if DepthDATA{i}{8} == 1
            totaleNF = totaleNF + 1; % aggiorno contatore nonFace
        else
            totaleF = totaleF + 1; % aggiorno contatore Face
        end
        if DepthDATA{i}{8} == 1 && results(i) == 0.5
            falseNegative = falseNegative+1; % aggiorno contatore FalseNegative
        elseif DepthDATA{i}{8} == 0.5 && results(i) == 0.5
            trueNegative = trueNegative + 1;
        end

        if results(i)== 1
            if DepthDATA{i}{8} == 0.5
                falsePositive = falsePositive+1; % aggiorno contatore falsePositive
            else
                truePositive = truePositive+1; % aggiorno contatore truePositive
            end
        end
    end
    
    precision = truePositive/(truePositive+falsePositive);
    recall = truePositive/(truePositive+falseNegative);
    
    testingData(k, 1) = marginRate;
    testingData(k, 2) = precision;
    testingData(k, 3) = recall;
    
    marginRate = marginRate + 0.01
    k = k + 1;
    
end

hold on
scatter(testingData(:,1), testingData(:,2), 'filled');
line(testingData(:,1), testingData(:,2))

scatter(testingData(:,1), testingData(:,3), 'filled', 'red');
line(testingData(:,1), testingData(:,3), 'Color', 'red')

