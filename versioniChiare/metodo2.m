% noFace si popolerà con gli indici delle immagini ritenuti non volti dai
% seguenti criteri
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
    
    matrix = DepthDATA{i}{2};
    maxMatrix = max(matrix(:));
    minMatrix = min(matrix(:));
    valorMedio = mean(matrix(:));
    testMedia = FixMatrix(matrix, maxMatrix);
    matrixCenter = round(size(testMedia, 1)/2);
    centralrow = testMedia(:,matrixCenter);
    centralColum = testMedia(matrixCenter, :);

    x = transpose(1:size(centralrow, 1));
    y = centralrow;
    
    f=fit(x,y,'poly2');
    %plot(f,x,y) 
    coefficientValues = coeffvalues(f);
    %if coefficientValues(2)>0.1     vecchio metodo (buono ma senza senso)
    verticeR = -coefficientValues(2)/(2.*coefficientValues(1));  %vertice della parabola
    
    
    x = transpose(1:size(transpose(centralColum)));
    y = transpose(centralColum);
    
    f=fit(x,y,'poly2');
    %plot(f,x,y) 
    coefficientValues = coeffvalues(f);
    %if coefficientValues(2)>0.1     vecchio metodo (buono ma senza senso)
    verticeC = -coefficientValues(2)/(2.*coefficientValues(1));
    
    
    
    if ((verticeR<0 || verticeR>size(testMedia, 1)) && (verticeC<0 || verticeC>size(testMedia, 1))) % controllo che il vertice sia interno all'immagine
        %{
        if i == 266
            disp(vertice)
            disp(size(testMedia, 1))
        end
        %}
        noFace(counter) = i;
        clusterData(i, 1) = 1;
        %clusterData(i, 3)  = vertice;
        %{
        if abs(vertice) < 2000
            clusterData(counter, 2)  = vertice;
            %clusterData(counter, 2)  = DepthDATA{i}{8};
            %clusterData(counter, 2) = size(testMedia, 1);
        end
        %}
        
        %{
        clusterData(counter, 2) = coefficientValues(1);
        clusterData(counter, 3) = coefficientValues(2);
        clusterData(counter, 4) = coefficientValues(3);
        %}
        counter = counter +1;
        if DepthDATA{i}{8} == 0.5
            falseNegative(gg) = i;
            gg = gg+1;
        end
    else
        clusterData(i, 1) = 0.5;
        %clusterData(i, 4)  = vertice;
    end
end

