function results = applicaMetodo(marginRate, sourceMatrix, concavityCheck)
    concavity = 1;
    if nargin > 2
        concavity = concavityCheck;
    end
    
    results = zeros(size(transpose(sourceMatrix),1), 1); %inizializzo l'array results vuoto

    for i = 1:size(transpose(sourceMatrix)) % analizzo tutte le immagini presenti in DepthDATA
        % considero la depth map della regione trovata dal face detector
      
        matrixVCenter = round(size(sourceMatrix{i}{2}, 1)/2); % trovo la riga centrale della matrice
        centralrow = sourceMatrix{i}{2}(matrixVCenter,:); % salvo nell'array centralrow i valori della riga centrale della metrice fixedMatrix

        % preparo i dati per effettuare il fit e la regressione parabolica
        x = transpose(1:size(centralrow, 2));
        y = double(transpose(centralrow));

        p = 1;
        while p <= size(y, 1) && size(y, 2) > 0
            %if isnan(y(p))
            if y(p) == 0
                x(p) = [];
                y(p) = [];
                p = p - 1;
            end
            p = p + 1;
        end

        if size(y, 1) >= 3

            f=fit(x,y,'poly2'); % effettuo la regressione parabolica

            coefficientValues = round(coeffvalues(f), 15); % estraggo i coefficenti dell'equazione di secondo grado dal fit

            vertice = -coefficientValues(2)/(2.*coefficientValues(1)); % individuo il vertice della parabola

            matrixHCenter = round(size(sourceMatrix{i}{2}, 2)/2); % trovo la colonna centrale della matrice

            marginA = matrixHCenter - marginRate*size(sourceMatrix{i}{2}, 2); % calcolo il primo margine spostandomi a sinistra rispetto alla colonna centrale
            marginB = matrixHCenter + marginRate*size(sourceMatrix{i}{2}, 2); % calcolo il secondo margine spostandomi a destra rispetto alla colonna centrale

            if isnan(vertice) || (concavity && coefficientValues(1) <= 0) || vertice < marginA || vertice > marginB % controllo che il vertice sia esterno ai margini o che la parabola sia concava
                results(i, 1) = 1; % allora essa viene identificata come nonFace
            else
                results(i, 1) = 0.5; % altrimenti vsiene identificata come face
            end
        else
            results(i, 1) = 1;
        end
    end
end
