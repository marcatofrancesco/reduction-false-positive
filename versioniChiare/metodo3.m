% noFace si popolerà con gli indici delle immagini ritenuti non volti dai seguenti criteri
% falseNegative sono immagini ritenute non volti dal fit ma che in realtà sono
% volti

noFace = [];
counter =1;
falseNegative = [];
gg = 1;
clusterData = [];
% ho fatto solo le prime 1000 immagini per comodità
%controllo le prime 1000 immagini dal label 2 (solo faccia)
for i = 1:1000
    %i
    matrix = DepthDATA{i}{2};
    maxMatrix = max(matrix(:));
    minMatrix = min(matrix(:));
    valorMedio = mean(matrix(:));
    testMedia = FixMatrix(matrix, maxMatrix); % qui si cambiano le due versioni del Metodo1
    matrixCenter = round(size(testMedia, 1)/2);
    centralrow = testMedia(matrixCenter,:);
    totalMax = max(DepthDATA{i}{3}(:));

    x = transpose(1:size(centralrow, 2));
    y = transpose(centralrow);
    
    f=fit(x,y,'poly2');

    coefficientValues = coeffvalues(f);
    %if coefficientValues(2)>0.1     vecchio metodo (buono ma senza senso)
    vertice = -coefficientValues(2)/(2.*coefficientValues(1));  %vertice della parabola

    if (vertice<0 || vertice>size(testMedia, 1)) % controllo che il vertice sia interno all'immagine
        
        noFace(counter) = i;
        clusterData(i, 1) = 1; % contrassegno il primo valore di cluster = 1 quindi non face
         
        if abs(vertice)>500
            clusterData(i, 2)  = 500; % secondo valore come abs
        else
            clusterData(i, 2)  = abs(vertice);
        end
        counter = counter +1;

    else
        clusterData(i, 1) = 0.5;
        if abs(vertice)>500
            clusterData(i, 2)  = 500; % secondo valore come abs
        else
            clusterData(i, 2)  = abs(vertice);
        end

    end
        
end


